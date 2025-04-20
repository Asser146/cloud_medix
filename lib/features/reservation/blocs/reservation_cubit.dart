import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/domain/make_reservation_repository.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:cloud_medix/features/reservation/my_reservations/domain/my_reservations_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final MakeReservationRespository makeResRepo =
      getIt<MakeReservationRespository>();
  final MyReservationsRepository myResRepo = getIt<MyReservationsRepository>();
  List<Slot> slots = [];
  List<MyReservation> reservations = [];
  late ApiResponse response;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
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

  Future<void> getSlots() async {
    emit(const ReservationLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const ReservationError("User ID is missing Error"));
      return;
    } else {
      response = await makeResRepo.getSlots(id);

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
}
