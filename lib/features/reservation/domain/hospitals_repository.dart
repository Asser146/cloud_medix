import 'dart:async';
import 'dart:convert';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/reservation/data/hospital.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    } on DioException {
      return ApiResponse(
          data: [], error: "Network error. Please check your connection.");
    } catch (e) {
      return ApiResponse(
          data: [], error: "Something went wrong. Please try again.");
    }
  }

  Future<void> cacheHospitals(List<Hospital> hospitals) async {
    final prefs = await SharedPreferences.getInstance();
    final hospitalListJson = hospitals.map((e) => e.toJson()).toList();
    final hospitalJsonString = jsonEncode(hospitalListJson);
    await prefs.setString('cached_hospitals', hospitalJsonString);
  }

  Future<List<Hospital>> getCachedHospitals() async {
    final prefs = await SharedPreferences.getInstance();
    final hospitalJsonString = prefs.getString('cached_hospitals');

    if (hospitalJsonString != null) {
      final List<dynamic> decoded = jsonDecode(hospitalJsonString);
      return decoded.map((e) => Hospital.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
