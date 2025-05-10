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

class MakeReservationProcessLoading extends MakeReservationState {
  final List<dynamic> list;

  const MakeReservationProcessLoading(this.list);
  @override
  List<Object> get props => [list];
}

class MakeReservationLoaded extends MakeReservationState {
  final List<dynamic> list;

  const MakeReservationLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class MakeReservationError extends MakeReservationState {
  final String message;

  const MakeReservationError(this.message);

  @override
  List<Object> get props => [message];
}
