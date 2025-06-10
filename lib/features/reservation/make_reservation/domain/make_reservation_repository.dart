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
    log('Entering getHospitalSlots: patientId=$patientId, hospitalId=$hospitalId');

    final client = getIt<ApiService>();

    try {
      log('Fetching hospital route for hospitalId=$hospitalId');
      final response = await client
          .getHospitalRoute(hospitalId)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        log('Timeout fetching hospital route for hospitalId=$hospitalId');
        return ApiResponse(
            data: "", error: "Server timeout. Please try again.");
      });

      log('Hospital route response: status=${response.status}, data=${response.data}');

      if (response.status == 200 && response.data != null) {
        final localUrl = response.data;
        log('Hospital route found: $localUrl');

        final dio = getIt<Dio>();
        final hospitalService = ApiService(dio, baseUrl: localUrl);
        log('Fetching slots for patientId=$patientId');
        final slotsResponse = await hospitalService
            .getallSlots(patientId)
            .timeout(const Duration(seconds: 10), onTimeout: () {
          log('Timeout fetching slots for patientId=$patientId');
          return ApiResponse(
              data: [], error: "Server timeout while fetching slots.");
        });

        log('Slots fetched successfully: status=${slotsResponse.status}, slots=${slotsResponse.data}');
        return slotsResponse;
      } else {
        log('Failed to fetch hospital route: status=${response.status}');
        return ApiResponse(data: [], error: "Network error. Try again later.");
      }
    } on DioException catch (e) {
      log('DioException in getHospitalSlots: ${e.message}');
      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      log('Unexpected error in getHospitalSlots: $e');
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    } finally {
      log('Exiting getHospitalSlots');
    }
  }

  Future<ApiResponse<String>> makeHospitalReservation(
      String patientId, int hospitalId, int slotID) async {
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
        ReservationBody requestBody = ReservationBody(
            slotId: slotID,
            reservationDate: DateTime.now(),
            hospitalPatientInternalId: hospitalId);

        final hospitalService = ApiService(dio, baseUrl: localUrl);
        final reservationResponse = await hospitalService
            .makeReservation(patientId, requestBody)
            .timeout(const Duration(seconds: 10), onTimeout: () {
          return ApiResponse(
              data: [], error: "Server timeout while fetching slots.");
        });

        return ApiResponse(
            status: reservationResponse.status,
            data: reservationResponse.data,
            error: "Server timeout while fetching slots.");
      } else {
        return ApiResponse(data: "", error: "No route found for hospital.");
      }
    } on DioException {
      return ApiResponse(
          data: "", error: "Network error. Please check your connection.");
    } catch (e) {
      return ApiResponse(
          data: "", error: "Something went wrong. Please try again.");
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
      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse(data: [], error: "No Slots Available");
      }
    } on DioException {
      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    }
  }
}
