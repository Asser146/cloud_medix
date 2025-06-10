import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_constants.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/auth/data/login_body.dart';
import 'package:cloud_medix/features/auth/data/login_response.dart';
import 'package:cloud_medix/features/auth/data/register_body.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  Future<ApiResponse> registerPatient(RegisterBody body) async {
    try {
      ApiService client = getIt<ApiService>();
      ApiResponse response = await client.register(body);
      if (response.status == 200 && response.error == null) {
        return ApiResponse(
          status: 200,
          data: null,
          error: null,
        );
      } else {
        return ApiResponse(
          status: 200,
          data: null,
          error: response.error,
        );
      }
    } on DioException catch (e) {
      return ApiResponse(status: 500, data: null, error: e.response?.data);
    } catch (e) {
      return ApiResponse(status: 500, data: null, error: e.toString());
    }
  }

  Future<LoginResponse> loginPatient(
      String inputUserName, String inputPassword) async {
    try {
      log("Attempting to log in user: $inputUserName");

      ApiService client = getIt<ApiService>();
      LoginBody loginBody =
          LoginBody(userName: inputUserName, password: inputPassword);

      // Log full endpoint
      final dio = getIt<Dio>(); // Make sure Dio is registered in getIt
      final baseUrl = dio.options.baseUrl;
      final endpoint = ApiConstants.login;
      log("Calling endpoint: $baseUrl$endpoint");

      log("Sending login request with body: ${loginBody.toJson()}");

      var response = await client.login(loginBody);

      log("Received response: status=${response.status}, data=${response.data}");

      if (response.status == 200 && response.data != null) {
        response.data!.add(loginBody.userName);
        log("Login successful. Parsed response data.");
        return LoginResponse.fromJson(response.data!);
      } else {
        log("Login failed or received empty data.");
        return LoginResponse(data: []);
      }
    } on DioException catch (dioError) {
      log("DioException occurred during login: ${dioError.message}");
      return LoginResponse(data: []);
    } catch (e) {
      log("Unexpected error during login: $e");
      return LoginResponse(data: []);
    }
  }
}
