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
      String patientId, int reservationId, int hospitalId) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getHospitalRoute(hospitalId)
          .timeout(const Duration(seconds: 25), onTimeout: () {
        return ApiResponse(
            data: "", error: "Server timeout. Please try again.");
      });
      if (response.status == 200 && response.data != null) {
        final localUrl = response.data;
        final dio = getIt<Dio>();
        final hospitalService = ApiService(dio, baseUrl: localUrl);
        final reservationResponse = await hospitalService
            .cancelReservation(patientId, reservationId)
            .timeout(const Duration(seconds: 10), onTimeout: () {
          return ApiResponse<String>(
              data: null, error: "Server timeout. Please try again.");
        });
        return ApiResponse(
            status: reservationResponse.status,
            data: reservationResponse.data,
            error: "Server timeout while fetching slots.");
      } else {
        return ApiResponse<String>(data: null, error: "No Reservations Done");
      }
    } on DioException catch (e) {
      log("DioException1: ${e.message}, type: ${e.type}, error: ${e.error}, response: ${e.response}");

      return ApiResponse(
          data: "", error: "Network error. Please check your connection.");
    } catch (e) {
      log("Unexpected Error: ${e.toString()}");
      return ApiResponse(
          data: "", error: "Something went wrong. Please try again.");
    }
  }
}
