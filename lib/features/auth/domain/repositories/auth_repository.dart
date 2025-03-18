import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/auth/data/models/address.dart';
import 'package:cloud_medix/features/auth/data/models/register_body.dart';
import 'package:dio/dio.dart';

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
        print("Registration Successful: ${response.data}");
      } else {
        print("Registration Failed: ${response.error}");
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.statusCode}");
      print("Error Data: ${e.response?.data}");
    } catch (e) {
      print("Unexpected Error: $e");
    }
  }
}
