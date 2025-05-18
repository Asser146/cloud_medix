import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:cloud_medix/features/auth/data/login_body.dart';
import 'package:cloud_medix/features/auth/data/login_response.dart';
import 'package:cloud_medix/features/auth/data/register_body.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class AuthRepository {
  Future<void> registerPatient() async {
    try {
      ApiService client = getIt<ApiService>();
      var response = await client.register(RegisterBody(
        userName: "asser_tamer",
        fullName: "Asser Tamer",
        nationalID: "30302929292929",
        date: "2025-03-14",
        phone: "+1234567890",
        address: Address(
            government: "Alexandria",
            city: "Alexandria",
            street: "Smouha",
            buildingNumber: 12),
        email: "asser@example.com",
        password: "SecurePass123!",
      ));

      if (response.status == 200) {
        log("Registration Successful: ${response.data}");
      } else {
        log("Registration Failed: ${response.error}");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.statusCode}");
      log("Error Data: ${e.response?.data}");
    } catch (e) {
      log("Unexpected Error: $e");
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
