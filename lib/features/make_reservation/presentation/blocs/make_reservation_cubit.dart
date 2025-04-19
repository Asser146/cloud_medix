import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/make_reservation/domain/reservation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'make_reservation_state.dart';

class MakeReservationCubit extends Cubit<MakeReservationState> {
  final ReservationRepository repo = getIt<ReservationRepository>();

  List<Slot> slots = [];
  late ApiResponse response;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  MakeReservationCubit() : super(const MakeReservationInitial()) {
    getSlots();
  }

  int? selectedSlotId;

  Future<void> reserveSlot(int slotID) async {
    emit(MakeReservationReserveLoading(List.from(slots)));
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MakeReservationError("User ID is missing Error"));
      return;
    }

    await repo.makeReservation(id, slotID);

    // Update slot locally
    int index = slots.indexWhere((slot) => slot.id == slotID);
    if (index != -1) {
      slots[index] = slots[index]
          .copyWith(reserved: true); // You need to implement copyWith
    }

    emit(MakeReservationLoaded(List.from(slots)));
  }

  Future<void> getSlots() async {
    emit(const MakeReservationLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MakeReservationError("User ID is missing Error"));
      return;
    } else {
      response = await repo.getSlots(id);

      if (response.status == 200 &&
          response.data != null &&
          response.data!.isNotEmpty) {
        slots = response.data!;
        emit(MakeReservationLoaded(List.from(slots)));
      } else {
        final errorMessage = response.error ?? "No slots available.";
        emit(MakeReservationError(errorMessage));
      }
    }
  }
}
