import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/my_reservations/data/my_reservation.dart';
import 'package:cloud_medix/features/my_reservations/domain/my_reservations_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'my_reservations_state.dart';

class MyReservationsCubit extends Cubit<MyReservationState> {
  final MyReservationsRepository repo = getIt<MyReservationsRepository>();
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  bool selected = false;
  List<MyReservation> reservations = [];
  late ApiResponse response;

  MyReservationsCubit() : super(const MyReservationsInitial()) {
    getReservations();
  }

  void reserveSlot(int slotID) {
    selected = !selected;
    emit(MyReservationsToggled(selected));
  }

  Future<void> getReservations() async {
    emit(const MyReservationsLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MyReservationsError("User ID is missing Error"));
      return;
    } else {
      response = await repo.getReservations(id);

      if (response.status == 200 &&
          response.data != null &&
          response.data.isNotEmpty) {
        reservations = response.data;
        emit(MyReservationsLoaded(List.from(reservations)));
      } else {
        final errorMessage = response.error ?? "No slots available.";
        emit(MyReservationsError(errorMessage));
      }
    }
  }
}
