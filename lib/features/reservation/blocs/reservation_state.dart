part of 'reservation_cubit.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object?> get props => [];
}

class ReservationInitial extends ReservationState {
  const ReservationInitial();
}

class ReservationLoading extends ReservationState {
  const ReservationLoading();
}

class ReservationProcessLoading extends ReservationState {
  final List<dynamic> list;

  const ReservationProcessLoading(this.list);
  @override
  List<Object> get props => [list];
}

class ReservationLoaded extends ReservationState {
  final List<dynamic> list;

  const ReservationLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class ReservationError extends ReservationState {
  final String message;

  const ReservationError(this.message);

  @override
  List<Object> get props => [message];
}

class ReservationUpdateSearchField extends ReservationState {
  final String newField;

  const ReservationUpdateSearchField(this.newField);

  @override
  List<Object?> get props => [newField];
}
