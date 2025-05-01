import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? "No API URL found";
  static const String settings = "SystemUser/patient";
  static const String updateSettings = "SystemUser/update_settings";

  static const String register = "SystemAccount/register-patient";
  static const String login = "SystemAccount/login-patient";
  static const String slots = "slots";
  static const String myReservations = "reservation/patient/central";
  static const String medicalRecord = "MedicalRecord/patientId";
  static const String makeReservation = "reservation";
  static const String cancelReservation = "reservation";
  static const String allTests = "test/patient/viewTestRequests/central";
  static const String testReult = "test/viewTestResults/central";
  static const String searchSlots = "slots/search";
}
