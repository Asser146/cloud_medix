import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? "No API URL found";
  static const String systemAccController = "SystemUser/patients";
  static const String register = "SystemAccount/register-patient";
  static const String login = "SystemAccount/login-patient";
  static const String slots = "slots";
  static const String medicalRecord = "MedicalRecord/patientId";
  // static const String sortDesc = "?sort=desc";
  // static const String jewCategory = "/category/jewelery";
}
