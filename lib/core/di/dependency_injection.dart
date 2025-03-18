import 'dart:io';

import 'package:cloud_medix/core/networking/api_constants.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/core/networking/dio_factory.dart';
import 'package:cloud_medix/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart'; // Import this for IOHttpClientAdapter
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  // Fix: Use IOHttpClientAdapter instead of DefaultHttpClientAdapter
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<ApiConstants>(() => ApiConstants());
  getIt.registerLazySingleton<ApiService>(
      () => ApiService(dio, baseUrl: ApiConstants.apiBaseUrl));
}
