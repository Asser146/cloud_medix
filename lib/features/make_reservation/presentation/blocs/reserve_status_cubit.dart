import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/make_reservation/data/hospital_slot.dart';
import 'package:cloud_medix/features/make_reservation/domain/reservation_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reserve_status_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepository repo = getIt<ReservationRepository>();
  bool selected = false;
  late List<HospitalSlot> slots;
  late ApiResponse response;
  ReservationCubit() : super(const ReserveStatusInitial()) {
    slots = [];
    getSlots();
  }

  void reserveSlot(String slotID) {
    selected = !selected;
    emit(ReserveStatusToggled(selected));
  }

  Future<void> getSlots() async {
    emit(const ReserveStatusLoading());
    try {
      response = await repo.getSlots();
      if (response.status == 200) {
        slots = response.data ?? [];
        if (slots.isNotEmpty) {
          emit(ReserveStatusLoaded(List.from(slots)));
        } else {
          emit(const ReserveStatusError("No slots available."));
        }
      } else {
        emit(const ReserveStatusError("No slots available."));
        return;
      }
    } on DioException catch (e) {
      ReserveStatusError("Dio Error,Failed to load slots: ${e.toString()}");
    } catch (e) {
      ReserveStatusError("Failed to load slots: ${e.toString()}");
    }
  }
}
