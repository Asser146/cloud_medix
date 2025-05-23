import 'dart:async';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_request.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_result.dart';
import 'package:dio/dio.dart';

class LabRepository {
  Future<ApiResponse<List<TestRequest>>> getMyTests(String id) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getAllTests(id)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return ApiResponse(
          data: null,
          error: "Request timed out\nPlease try again later.",
        );
      });

      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse(
          status: response.status,
          data: null,
          error: "Network error\nPlease check your connection and try again.",
        );
      }
    } on DioException {
      return ApiResponse(
        data: null,
        error: "Network error\nPlease check your connection and try again.",
      );
    } catch (e) {
      return ApiResponse(
        data: null,
        error: "Something went wrong\nPlease try again.",
      );
    }
  }

  Future<ApiResponse<TestResult>> getTestResult(
      String id, String testId) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getTestResult(id, testId)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return ApiResponse(
          data: null,
          error: "Request timed out\nPlease try again later.",
        );
      });

      if (response.status == 200) {
        return response;
      } else {
        return ApiResponse(
          status: 500,
          data: null,
          error: "Server Error\nplease try again later.",
        );
      }
    } on DioException {
      return ApiResponse(
        data: null,
        error: "Network error\nPlease check your connection and try again.",
      );
    } catch (e) {
      return ApiResponse(
        data: null,
        error: "Something went wrong\nPlease try again.",
      );
    }
  }
}
