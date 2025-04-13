import 'dart:async';
import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/make_reservation/data/hospital_slot.dart';
import 'package:dio/dio.dart';

class ReservationRepository {
  Future<ApiResponse<List<HospitalSlot>>> getSlots() async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getallSlots()
          .timeout(const Duration(seconds: 5), onTimeout: () {
        log("Timeout: Server took too long to respond.");
        return ApiResponse(
            data: [], error: "Server timeout. Please try again.");
      });

      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse(data: [], error: "No Medical Record Available");
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
}
