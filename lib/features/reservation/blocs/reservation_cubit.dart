import 'dart:async';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/reservation/data/hospital.dart';
import 'package:cloud_medix/features/reservation/domain/hospitals_repository.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/domain/make_reservation_repository.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:cloud_medix/features/reservation/my_reservations/domain/my_reservations_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  bool slotsFetched = false;

  Timer? _doctorDebounce;
  Timer? _departmentDebounce;

  final MakeReservationRespository makeResRepo =
      getIt<MakeReservationRespository>();
  final MyReservationsRepository myResRepo = getIt<MyReservationsRepository>();
  final HospitalsRespository hospitalsRepo = getIt<HospitalsRespository>();
  int? selectedHospitalId; // Add this line

  List<Slot> slots = [];
  List<Hospital> hospitals = [];
  List<MyReservation> reservations = [];
  late ApiResponse response;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  String doctorFilter = '';
  String departmentFilter = '';

  ReservationCubit() : super(const ReservationInitial());

  Future<void> reserveSlot(int slotID) async {
    emit(ReservationProcessLoading(List.from(slots))); // Show loading
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const ReservationError("User ID is missing Error"));
      return;
    }
    await makeResRepo.makeReservation(id, slotID);
    int index = slots.indexWhere((slot) => slot.id == slotID);
    if (index != -1) {
      slots[index] = slots[index].copyWith(reserved: true);
    }
    emit(ReservationLoaded(List.from(slots)));
  }

  Future<void> cancelReservation(int reservationId) async {
    emit(ReservationProcessLoading(List.from(reservations))); // Show loading
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const ReservationError("User ID is missing Error"));
      return;
    }
    final cancelResponse = await myResRepo.cancelReservation(id, reservationId);
    if (cancelResponse.status == 200) {
      reservations
          .removeWhere((reservation) => reservation.id == reservationId);
      emit(ReservationLoaded(List.from(reservations)));
    } else {
      emit(ReservationError(
          cancelResponse.error ?? "Failed to cancel the reservation"));
    }
  }

  Future<void> getReservations() async {
    emit(const ReservationLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const ReservationError("User ID is missing Error"));
      return;
    } else {
      response = await myResRepo.getReservations(id);

      if (response.status == 200 &&
          response.data != null &&
          response.data.isNotEmpty) {
        reservations = response.data;
        emit(ReservationLoaded(List.from(reservations)));
      } else {
        final errorMessage = response.error ?? "No slots available.";
        emit(ReservationError(errorMessage));
      }
    }
  }

  Future<void> getHospitals() async {
    response = await hospitalsRepo.getRegisteredHospitals();
    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      hospitals = response.data!;
    } else {
      final errorMessage = response.error ?? "No slots available.";
      emit(ReservationError(errorMessage));
    }
  }

  Future<void> changeHospital(int hospitalId) async {
    emit(const ReservationLoading());
    selectedHospitalId = hospitalId; // Set it here

    String? userId = await storage.read(key: "id");
    if (userId == null) {
      emit(const ReservationError("User ID is missing"));
      return;
    }

    response = await makeResRepo.getHospitalSlots(userId, hospitalId);
    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      slots = response.data!;
      emit(ReservationLoaded(List.from(slots)));
    } else {
      final errorMessage =
          response.error ?? "No slots available for this hospital.";
      emit(ReservationError(errorMessage));
    }
  }

  Future<void> getSlots(bool isRefresh) async {
    if (slotsFetched) return;
    slotsFetched = true;
    isRefresh
        ? emit(ReservationProcessLoading(slots))
        : emit(const ReservationLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const ReservationError("User ID is missing Error"));
      return;
    } else {
      await getHospitals();
      response = await makeResRepo.getHospitalSlots(
          id, selectedHospitalId ?? hospitals[0].hospitalId);

      if (response.status == 200 &&
          response.data != null &&
          response.data!.isNotEmpty) {
        slots = response.data!;
        emit(ReservationLoaded(List.from(slots)));
      } else {
        final errorMessage = response.error ?? "No slots available.";
        emit(ReservationError(errorMessage));
      }
    }
  }

  Future<void> refreshSlots() async {
    slotsFetched = false; // Reset flag on manual refresh
    await getSlots(true);
  }

  void searchDoctor(String value) {
    _doctorDebounce?.cancel();
    _doctorDebounce = Timer(const Duration(milliseconds: 1000), () {
      searchSlots(doctor: value);
    });
  }

  void searchDepartment(String value) {
    _departmentDebounce?.cancel();
    _departmentDebounce = Timer(const Duration(milliseconds: 1000), () {
      searchSlots(department: value);
    });
  }

  Future<void> searchSlots({String? doctor, String? department}) async {
    // Replace this with your actual search logic
    emit(ReservationProcessLoading(slots));
    if (doctor != null) doctorFilter = doctor;
    if (department != null) departmentFilter = department;
    if (doctor == null && department == null) {
      getSlots(true);
      return;
    }
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const ReservationError("User ID is missing Error"));
      return;
    }
    response =
        await makeResRepo.filterSlots(id, doctorFilter, departmentFilter);

    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      slots = response.data!;
      emit(ReservationLoaded(slots));
    } else {
      final errorMessage = response.error ?? "No slots available.";
      emit(ReservationError(errorMessage));
    }
  }
}
