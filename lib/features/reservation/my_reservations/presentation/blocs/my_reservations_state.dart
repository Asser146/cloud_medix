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

class MyReservationsProcessLoading extends MyReservationsState {
  final List<dynamic> list;

  const MyReservationsProcessLoading(this.list);
  @override
  List<Object> get props => [list];
}

class MyReservationsLoaded extends MyReservationsState {
  final List<dynamic> list;

  const MyReservationsLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class MyReservationsError extends MyReservationsState {
  final String message;

  const MyReservationsError(this.message);

  @override
  List<Object> get props => [message];
}
