import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/medical_record/data/medical_record.dart';
import 'package:dio/dio.dart';

class MedicalRecordRepository {
  Future<ApiResponse<MedicalRecord>> getMyMedicalRecord(String id) async {
    ApiService client = getIt<ApiService>();

    try {
      var response = await client.getMedicalRecord(id);
      if (response.status == 200) {
        return response;
      } else {
        log("No medicalRecord available.");
        return response;
      }
    } on DioException catch (e) {
      log("Dio Error,Failed to load medicalRecord: ${e.toString()}");
      rethrow;
    } catch (e) {
      log("Failed to load medicalRecord: ${e.toString()}");
      rethrow;
    }
  }
}
