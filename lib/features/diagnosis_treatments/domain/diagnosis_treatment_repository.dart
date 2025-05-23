import 'dart:async';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/diagnosis_treatments/data/diagnosis.dart';
import 'package:cloud_medix/features/diagnosis_treatments/data/treatment.dart';
import 'package:dio/dio.dart';

class DiagnosisTreatmentRepository {
  Future<ApiResponse<List<Treatment>>> getPatientTreatment(String id) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getTreatment(id)
          .timeout(const Duration(seconds: 5), onTimeout: () {
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
          error: "No medical record found for this user.",
        );
      }
    } on DioException {
      return ApiResponse(
        data: null,
        error: "Network error. Please check your connection and try again.",
      );
    } catch (e) {
      return ApiResponse(
        data: null,
        error: "Something went wrong. Please try again.",
      );
    }
  }

  Future<ApiResponse<List<Diagnosis>>> getPatientDiagnosis(String id) async {
    final client = getIt<ApiService>();

    try {
      final response = await client
          .getDiagnosis(id)
          .timeout(const Duration(seconds: 5), onTimeout: () {
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
          error: "No medical record found for this user.",
        );
      }
    } on DioException {
      return ApiResponse(
        data: null,
        error: "Network error. Please check your connection and try again.",
      );
    } catch (e) {
      return ApiResponse(
        data: null,
        error: "Something went wrong. Please try again.",
      );
    }
  }
}
