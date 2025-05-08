import 'dart:async';
import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/reservation_body.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:dio/dio.dart';

class MakeReservationRespository {
  Future<ApiResponse<List<Slot>>> getHospitalSlots(
      String patientId, int hospitalId) async {
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
        final slotsResponse = await hospitalService
            .getallSlots(patientId)
            .timeout(const Duration(seconds: 10), onTimeout: () {
          return ApiResponse(
              data: [], error: "Server timeout while fetching slots.");
        });

        return slotsResponse;
      } else {
        return ApiResponse(data: [], error: "No route found for hospital.");
      }
    } on DioException catch (e) {
      log("DioException1: ${e.message}, type: ${e.type}, error: ${e.error}, response: ${e.response}");

      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      log("Unexpected Error: ${e.toString()}");
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    }
  }

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
      log("Unexpected Error0: ${e.toString()}");
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
      log("DioException1: ${e.message}");
      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      log("Unexpected Error1: ${e.toString()}");
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    }
  }

  Future<ApiResponse<List<Slot>>> filterSlots(
      String id, String docName, String depName) async {
    final client = getIt<ApiService>();
    try {
      final response = await client
          .filterSlots(id, docName, depName)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return ApiResponse(
            data: [], error: "Server timeout. Please try again.");
      });
      log(response.toString());
      if (response.status == 200) {
        log(response.toString());
        return response;
      } else {
        return ApiResponse(data: [], error: "No Slots Available");
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      log("Unexpected Error2: ${e.toString()}");
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    }
  }
}
