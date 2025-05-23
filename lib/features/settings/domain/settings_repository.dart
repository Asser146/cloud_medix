import 'dart:async';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/settings/data/update_patient_body.dart';
import 'package:cloud_medix/features/settings/data/user.dart';
import 'package:dio/dio.dart';

class SettingsRepository {
  Future<ApiResponse<User>> getMySettings(String id) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getUserSettings(id)
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
          data: null,
          error: "No Settings found for this user.",
        );
      }
    } on DioException {
      return ApiResponse(
        data: null,
        error: "Network error\nPlease try again later",
      );
    } catch (e) {
      return ApiResponse(
        data: null,
        error: "Something went wrong. Please try again.",
      );
    }
  }

  Future<ApiResponse> updateSettings(String id, UpdatePatientBody body) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .updateSettings(id, body)
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
          data: null,
          error: "No Settings found for this user.",
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
        error: "Something went wrong. Please try again.",
      );
    }
  }
}
