import 'dart:async';
import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/reservation/domain/hospitals_repository.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:cloud_medix/features/reservation/my_reservations/domain/my_reservations_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'my_reservations_state.dart';

class MyReservationsCubit extends Cubit<MyReservationsState> {
  bool slotsFetched = false;

  final MyReservationsRepository myResRepo = getIt<MyReservationsRepository>();
  final HospitalsRespository hospitalsRepo = getIt<HospitalsRespository>();
  List<MyReservation> reservations = [];
  late ApiResponse response;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  MyReservationsCubit() : super(const MyReservationsInitial());

  Future<void> cancelMyReservations(int reservationId) async {
    emit(MyReservationsProcessLoading(List.from(reservations))); // Show loading
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MyReservationsError("User ID is missing Error"));
      return;
    }
    final cancelResponse = await myResRepo.cancelReservation(id, reservationId);
    if (cancelResponse.status == 200) {
      reservations
          .removeWhere((reservation) => reservation.id == reservationId);
      emit(MyReservationsLoaded(List.from(reservations)));
    } else {
      emit(MyReservationsError(
          cancelResponse.error ?? "Failed to cancel the MyReservations"));
    }
  }

  Future<void> getMyReservationss() async {
    emit(const MyReservationsLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MyReservationsError("User ID is missing Error"));
      return;
    } else {
      response = await myResRepo.getReservations(id);
      // log(response.data[0].toJson().toString());
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
