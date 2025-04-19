part of 'my_reservations_cubit.dart';

abstract class MyReservationsState extends Equatable {
  const MyReservationsState();

  @override
  List<Object?> get props => [];
}

class MyReservationsInitial extends MyReservationsState {
  const MyReservationsInitial();
}

class MyReservationsLoading extends MyReservationsState {
  const MyReservationsLoading();
}

class MyReservationsLoaded extends MyReservationsState {
  final List<MyReservation> reservations;

  const MyReservationsLoaded(this.reservations);

  @override
  List<Object> get props => [reservations];
}

class MyReservationsError extends MyReservationsState {
  final String message;

  const MyReservationsError(this.message);

  @override
  List<Object> get props => [message];
}
