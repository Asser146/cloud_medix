import 'dart:async';
import 'dart:convert';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/reservation/domain/hospitals_repository.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:cloud_medix/features/reservation/my_reservations/domain/my_reservations_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    String? userId = await storage.read(key: "id");
    if (userId == null) {
      emit(const MyReservationsError("User ID is missing Error"));
      return;
    }

    final reservation = reservations.firstWhere((r) => r.id == reservationId);
    final int slotId = reservation.localSlotId;
    final int hospitalId = reservation.hospital.id;

    final cancelResponse =
        await myResRepo.cancelReservation(userId, reservationId, hospitalId);

    if (cancelResponse.status == 200) {
      final index = reservations.indexWhere((r) => r.id == reservationId);
      if (index != -1) {
        reservations[index] =
            reservations[index].copyWith(status: 1); // 1 = canceled
      }

      // Remove the slot from SharedPreferences map
      final prefs = await SharedPreferences.getInstance();
      const String key = "hospital_slot_map";
      final existingData = prefs.getString(key);

      if (existingData != null) {
        final Map<String, dynamic> userMap = jsonDecode(existingData);
        final userKey = userId;
        final hospitalKey = hospitalId.toString();

        if (userMap.containsKey(userKey)) {
          Map<String, dynamic> hospitalMap =
              Map<String, dynamic>.from(userMap[userKey]);

          if (hospitalMap.containsKey(hospitalKey)) {
            List<Map<String, dynamic>> slotList =
                List<Map<String, dynamic>>.from(hospitalMap[hospitalKey]);

            // Remove the slot by ID
            slotList.removeWhere((slot) => slot['id'] == slotId);

            hospitalMap[hospitalKey] = slotList;
            userMap[userKey] = hospitalMap;

            await prefs.setString(key, jsonEncode(userMap));
          }
        }
      }

      emit(MyReservationsLoaded(List.from(reservations)));
    } else {
      emit(MyReservationsError(
          cancelResponse.error ?? "Failed to cancel the reservation"));
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
      if (response.status == 200 &&
          response.data != null &&
          response.data.isNotEmpty) {
        reservations = response.data;
        emit(MyReservationsLoaded(List.from(reservations)));
      } else if (response.status == 200 &&
          response.data != null &&
          response.data!.isEmpty) {
        reservations = [];
        emit(MyReservationsLoaded(List.from(reservations)));
      } else {
        final errorMessage = response.error ?? "Error, Try Again Later";
        emit(MyReservationsError(errorMessage));
      }
    }
  }
}
