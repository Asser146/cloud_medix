import 'dart:async';
import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/make_reservation/data/reservation_body.dart';
import 'package:cloud_medix/features/make_reservation/data/slot.dart';
import 'package:dio/dio.dart';

class ReservationRepository {
  Future<ApiResponse<List<Slot>>> getSlots(String id) async {
    final client = getIt<ApiService>();
    try {
      final response = await client
          .getallSlots(id)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return ApiResponse(
            data: [], error: "Server timeout. Please try again.");
      });

      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse(data: [], error: "No Slots Available");
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      log("Unexpected Error1: ${e.toString()}");
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    }
  }

  Future<ApiResponse> makeReservation(String patientId, int slotID) async {
    final client = getIt<ApiService>();
    try {
      ReservationBody requestBody = ReservationBody(
          slotId: slotID, reservationDate: DateTime.now(), patientId: 1);
      final response = await client
          .makeReservation(patientId, requestBody)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return ApiResponse(
            data: [], error: "Server timeout. Please try again.");
      });

      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse(data: [], error: "No Slots Available");
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      log("Unexpected Error1: ${e.toString()}");
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    }
  }
}
