import 'dart:async';
import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_request.dart';
import 'package:dio/dio.dart';

class LabRepository {
  Future<ApiResponse<List<TestRequest>>> getMyTests(String id) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getAllTests(id)
          .timeout(const Duration(seconds: 5), onTimeout: () {
        log("Timeout: Server took too long to respond.");
        return ApiResponse(
          data: null,
          error: "Request timed out. Please try again later.",
        );
      });

      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse(
          data: null,
          error: "No Tests found for this user.",
        );
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      return ApiResponse(
        data: null,
        error: "Network error. Please check your connection and try again.",
      );
    } catch (e) {
      log("Unexpected error: ${e.toString()}");
      return ApiResponse(
        data: null,
        error: "Something went wrong. Please try again.",
      );
    }
  }
}
