part of 'reserve_status_cubit.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object?> get props => [];
}

class ReserveStatusInitial extends ReservationState {
  const ReserveStatusInitial();
}

class ReserveStatusLoading extends ReservationState {
  const ReserveStatusLoading();
}

class ReserveStatusLoaded extends ReservationState {
  final List<HospitalSlot> slots;

  const ReserveStatusLoaded(this.slots);

  @override
  List<Object> get props => [slots];
}

class ReserveStatusToggled extends ReservationState {
  final bool selected;

  const ReserveStatusToggled(this.selected);

  @override
  List<Object> get props => [selected];
}

class ReserveStatusError extends ReservationState {
  final String message;

  const ReserveStatusError(this.message);

  @override
  List<Object> get props => [message];
}
