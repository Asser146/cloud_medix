import 'dart:async';
import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/reservation/data/hospital.dart';
import 'package:cloud_medix/features/reservation/domain/hospitals_repository.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/domain/make_reservation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

part 'make_reservation_state.dart';

class MakeReservationCubit extends Cubit<MakeReservationState> {
  bool slotsFetched = false;

  Timer? _doctorDebounce;
  Timer? _departmentDebounce;

  final MakeReservationRespository makeResRepo =
      getIt<MakeReservationRespository>();
  final HospitalsRespository hospitalsRepo = getIt<HospitalsRespository>();
  int? selectedHospitalId;

  List<Slot> slots = [];
  List<Hospital> hospitals = [];
  late ApiResponse response;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  String doctorFilter = '';
  String departmentFilter = '';

  MakeReservationCubit() : super(const MakeReservationInitial());

  Future<void> reserveSlot(int slotID) async {
    emit(MakeReservationProcessLoading(List.from(slots))); // Show loading
    String? id = await storage.read(key: "id");
    selectedHospitalId = selectedHospitalId ?? hospitals[0].id;

    if (id == null || selectedHospitalId == null) {
      emit(const MakeReservationError("Server Error or User error Id"));
      return;
    }

    await makeResRepo.makeHospitalReservation(id, selectedHospitalId!, slotID);

    int index = slots.indexWhere((slot) => slot.id == slotID);
    if (index != -1) {
      slots[index] = slots[index].copyWith(reserved: true);
    }

    // Save mapping to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String key = "hospital_slot_map";

    // Load existing data
    final existingData = prefs.getString(key);
    Map<String, List<int>> hospitalSlotMap = {};

    if (existingData != null) {
      final decoded = jsonDecode(existingData) as Map<String, dynamic>;
      hospitalSlotMap = decoded.map(
        (k, v) => MapEntry(k, List<int>.from(v)),
      );
    }

    // Convert hospitalId to string for JSON map key
    final hospitalKey = selectedHospitalId!.toString();

    // Update the list for the current hospital
    hospitalSlotMap.update(
      hospitalKey,
      (existingList) => {...existingList, slotID}.toList(), // remove duplicates
      ifAbsent: () => [slotID],
    );

    // Save updated map
    await prefs.setString(key, jsonEncode(hospitalSlotMap));

    emit(MakeReservationLoaded(List.from(slots)));
  }

  Future<void> getHospitals() async {
    response = await hospitalsRepo.getRegisteredHospitals();
    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      hospitals = response.data!;
    } else {
      final errorMessage = response.error ?? "No slots available.";
      emit(MakeReservationError(errorMessage));
    }
  }

  Future<void> changeHospital(int hospitalId) async {
    emit(const MakeReservationLoading());
    selectedHospitalId = hospitalId;

    String? userId = await storage.read(key: "id");
    if (userId == null) {
      emit(const MakeReservationError("User ID is missing"));
      return;
    }

    response = await makeResRepo.getHospitalSlots(userId, hospitalId);

    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      slots = response.data!;

      // Load reserved slots from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String key = "hospital_slot_map";
      final hospitalKey = hospitalId.toString();
      final existingData = prefs.getString(key);
      List<int> reservedSlotIds = [];

      if (existingData != null) {
        final decoded = jsonDecode(existingData) as Map<String, dynamic>;
        if (decoded.containsKey(hospitalKey)) {
          reservedSlotIds = List<int>.from(decoded[hospitalKey]);
        }
      }

      // Set reserved = true if in list, else reserved = false
      slots = slots.map((slot) {
        final isReserved = reservedSlotIds.contains(slot.id);
        return slot.copyWith(reserved: isReserved);
      }).toList();

      emit(MakeReservationLoaded(List.from(slots)));
    } else {
      final errorMessage =
          response.error ?? "No slots available for this hospital.";
      emit(MakeReservationError(errorMessage));
    }
  }

  Future<void> getSlots(bool isRefresh) async {
    if (slotsFetched) return;
    slotsFetched = true;
    isRefresh
        ? emit(MakeReservationProcessLoading(slots))
        : emit(const MakeReservationLoading());

    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MakeReservationError("User ID is missing Error"));
      return;
    } else {
      await getHospitals();
      selectedHospitalId = selectedHospitalId ?? hospitals[0].id;

      response = await makeResRepo.getHospitalSlots(id, selectedHospitalId!);

      if (response.status == 200 &&
          response.data != null &&
          response.data!.isNotEmpty) {
        slots = response.data!;

        // Load reserved slots from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final String key = "hospital_slot_map";
        final hospitalKey = selectedHospitalId!.toString();
        // await prefs.remove("hospital_slot_map");
        final existingData = prefs.getString(key);
        // Print the full hospital-slot map
        List<int> reservedSlotIds = [];

        if (existingData != null) {
          final decoded = jsonDecode(existingData) as Map<String, dynamic>;
          if (decoded.containsKey(hospitalKey)) {
            reservedSlotIds = List<int>.from(decoded[hospitalKey]);
          }
        }

        // Set reserved = true if in list, else reserved = false
        slots = slots.map((slot) {
          final isReserved = reservedSlotIds.contains(slot.id);
          return slot.copyWith(reserved: isReserved);
        }).toList();

        emit(MakeReservationLoaded(List.from(slots)));
      } else {
        final errorMessage = response.error ?? "No slots available.";
        emit(MakeReservationError(errorMessage));
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
    emit(MakeReservationProcessLoading(slots));
    if (doctor != null) doctorFilter = doctor;
    if (department != null) departmentFilter = department;
    if (doctor == null && department == null) {
      getSlots(true);
      return;
    }
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MakeReservationError("User ID is missing Error"));
      return;
    }
    response =
        await makeResRepo.filterSlots(id, doctorFilter, departmentFilter);

    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      slots = response.data!;
      emit(MakeReservationLoaded(slots));
    } else {
      final errorMessage = response.error ?? "No slots available.";
      emit(MakeReservationError(errorMessage));
    }
  }
}
