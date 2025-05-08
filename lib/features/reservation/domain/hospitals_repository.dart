import 'dart:async';
import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/reservation/data/hospital.dart';
import 'package:dio/dio.dart';

class HospitalsRespository {
  Future<ApiResponse<List<Hospital>>> getRegisteredHospitals() async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getAllHospitals()
          .timeout(const Duration(seconds: 25), onTimeout: () {
        return ApiResponse(
            data: [], error: "Server timeout. Please try again.");
      });

      if (response.status == 200 && response.data != null) {
        return response;
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
}
