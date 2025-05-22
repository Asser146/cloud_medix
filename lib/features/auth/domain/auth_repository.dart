import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:cloud_medix/features/auth/data/login_body.dart';
import 'package:cloud_medix/features/auth/data/login_response.dart';
import 'package:cloud_medix/features/auth/data/register_body.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

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
      log("Dio Error: ${e.response?.statusCode}");
      log("Error Data: ${e.response?.data}");
      return ApiResponse(status: 500, data: null, error: e.response?.data);
    } catch (e) {
      log("Unexpected Error: $e");
      return ApiResponse(status: 500, data: null, error: e.toString());
    }
  }

  Future<LoginResponse> loginPatient(
      String inputUserName, String inputPassword) async {
    try {
      ApiService client = getIt<ApiService>();
      LoginBody loginBody =
          LoginBody(userName: inputUserName, password: inputPassword);
      var response = await client.login(
        loginBody,
      );
      if (response.status == 200 && response.data != null) {
        response.data!.add(loginBody.userName);
        return LoginResponse.fromJson(response.data!);
      } else {
        log("Login Failed: ${response.error}");
        return LoginResponse(data: []);
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.statusCode}");
      log("Error Data: ${e.response?.data}");
      return LoginResponse(data: []);
    } catch (e) {
      log("Unexpected Error: $e");
      return LoginResponse(data: []);
    }
  }
}
