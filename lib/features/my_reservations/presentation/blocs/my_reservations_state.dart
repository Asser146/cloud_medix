part of 'my_reservations_cubit.dart';

abstract class MyReservationState extends Equatable {
  const MyReservationState();

  @override
  List<Object?> get props => [];
}

class MyReservationsInitial extends MyReservationState {
  const MyReservationsInitial();
}

class MyReservationsLoading extends MyReservationState {
  const MyReservationsLoading();
}

class MyReservationsLoaded extends MyReservationState {
  final List<MyReservation> reservations;

  const MyReservationsLoaded(this.reservations);

  @override
  List<Object> get props => [reservations];
}

class MyReservationsToggled extends MyReservationState {
  final bool selected;

  const MyReservationsToggled(this.selected);

  @override
  List<Object> get props => [selected];
}

class MyReservationsError extends MyReservationState {
  final String message;

  const MyReservationsError(this.message);

  @override
  List<Object> get props => [message];
}
