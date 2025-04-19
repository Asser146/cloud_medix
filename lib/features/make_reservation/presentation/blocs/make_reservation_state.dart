part of 'make_reservation_cubit.dart';

abstract class MakeReservationState extends Equatable {
  const MakeReservationState();

  @override
  List<Object?> get props => [];
}

class MakeReservationInitial extends MakeReservationState {
  const MakeReservationInitial();
}

class MakeReservationLoading extends MakeReservationState {
  const MakeReservationLoading();
}

class MakeReservationLoaded extends MakeReservationState {
  final List<Slot> slots;

  const MakeReservationLoaded(this.slots);

  @override
  List<Object> get props => [slots];
}

class MakeReservationError extends MakeReservationState {
  final String message;

  const MakeReservationError(this.message);

  @override
  List<Object> get props => [message];
}
