import 'dart:io';

import 'package:cloud_medix/core/networking/api_constants.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/core/networking/dio_factory.dart';
import 'package:cloud_medix/features/auth/domain/auth_repository.dart';
import 'package:cloud_medix/features/diagnosis_treatments/domain/diagnosis_treatment_repository.dart';
import 'package:cloud_medix/features/reservation/domain/hospitals_repository.dart';
import 'package:cloud_medix/features/reservation/make_reservation/domain/make_reservation_repository.dart';
import 'package:cloud_medix/features/medical_record/domain/medical_record_repository.dart';
import 'package:cloud_medix/features/reservation/my_reservations/domain/my_reservations_repository.dart';
import 'package:cloud_medix/features/settings/domain/settings_repository.dart';
import 'package:cloud_medix/features/tests_scan_results/domain/lab_repository.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

// Fix: Register Dio for reuse
  getIt.registerLazySingleton<Dio>(() => dio); // 🔥 THIS IS REQUIRED

  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => FlutterSecureStorage());
  getIt.registerLazySingleton<HospitalsRespository>(
      () => HospitalsRespository());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<MakeReservationRespository>(
      () => MakeReservationRespository());
  getIt.registerLazySingleton<MedicalRecordRepository>(
      () => MedicalRecordRepository());
  getIt.registerLazySingleton<LabRepository>(() => LabRepository());
  getIt.registerLazySingleton<MyReservationsRepository>(
      () => MyReservationsRepository());
  getIt.registerLazySingleton<ApiConstants>(() => ApiConstants());
  getIt.registerLazySingleton<ApiService>(
      () => ApiService(dio, baseUrl: ApiConstants.apiBaseUrl));
  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepository());
  getIt.registerLazySingleton<DiagnosisTreatmentRepository>(
      () => DiagnosisTreatmentRepository());
}
