import 'dart:async';
import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:dio/dio.dart';

class MyReservationsRepository {
  Future<ApiResponse<List<MyReservation>>> getReservations(String id) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getMyReservations(id)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return ApiResponse(
            data: [], error: "Server timeout. Please try again.");
      });
      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse(data: [], error: "No Reservations Done");
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      log("Unexpected Error: ${e.toString()}");
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    }
  }

  Future<ApiResponse<String>> cancelReservation(
      String patientId, int reservationId) async {
    final client = getIt<ApiService>();
    try {
      final response = await client
          .cancelReservation(patientId, reservationId)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return ApiResponse<String>(
            data: null, error: "Server timeout. Please try again.");
      });

      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse<String>(data: null, error: "No Reservations Done");
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      return ApiResponse<String>(
          data: null, error: "Network error. Please check your connection.");
    } catch (e) {
      log("Unexpected Error1: ${e.toString()}");
      return ApiResponse<String>(
          data: null, error: "Something went wrong. Please try again.");
    }
  }
}
