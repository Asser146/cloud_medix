import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/make_reservation/domain/reservation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reserve_status_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepository repo = getIt<ReservationRepository>();

  bool selected = false;
  List<Slot> slots = [];
  late ApiResponse response;

  ReservationCubit() : super(const ReserveStatusInitial()) {
    getSlots();
  }

  void reserveSlot(int slotID) {
    selected = !selected;
    emit(ReserveStatusToggled(selected));
  }

  Future<void> getSlots() async {
    emit(const ReserveStatusLoading());
    response = await repo.getSlots();

    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      slots = response.data!;
      emit(ReserveStatusLoaded(List.from(slots)));
    } else {
      final errorMessage = response.error ?? "No slots available.";
      emit(ReserveStatusError(errorMessage));
    }
  }
}
