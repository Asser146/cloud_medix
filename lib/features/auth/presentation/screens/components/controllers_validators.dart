import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Controllers
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController nationalIdController = TextEditingController();
final TextEditingController governmentController = TextEditingController();
final TextEditingController cityController = TextEditingController();
final TextEditingController streetController = TextEditingController();
final TextEditingController buildingNumberController = TextEditingController();
final TextEditingController floorController = TextEditingController();
final TextEditingController apartmentNumberController = TextEditingController();
final TextEditingController birthdateController = TextEditingController();
final ValueNotifier<String?> genderNotifier = ValueNotifier<String?>(null);

// Validation Functions

String validateName(String name) {
  final RegExp nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
  if (name.isEmpty) return "Name cannot be empty";
  if (!nameRegExp.hasMatch(name)) {
    return "Name must contain only letters and spaces";
  }
  return "";
}

String validateUsername(String username) {
  final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
  if (username.isEmpty) return "Username cannot be empty";
  if (username.length < 3) return "Username must be at least 3 characters long";
  if (!usernameRegExp.hasMatch(username)) {
    return "Username can only contain letters, numbers, and underscores";
  }
  return "";
}

String validateEmail(String email) {
  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$");
  if (email.isEmpty) return "Email cannot be empty";
  if (!emailRegExp.hasMatch(email)) return "Enter a valid email address";
  return "";
}

String validateRegisterPassword(String password) {
  if (password.isEmpty) return "Password cannot be empty";
  if (password.length < 8) return "Password must be at least 8 characters long";
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return "Password must contain at least one uppercase letter";
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return "Password must contain at least one lowercase letter";
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return "Password must contain at least one number";
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_]'))) {
    return "Password must contain at least one special character";
  }
  return "";
}

String validateConfirmPass(String password) {
  if (password.isEmpty) return "Confirm Password cannot be empty";
  if (password != passController.text) return "Password mis-match";
  return "";
}

String validateDOB(String dobText) {
  if (dobText.isEmpty) return "Date of Birth cannot be empty";
  try {
    DateTime dob = DateFormat('yyyy-MM-dd').parse(dobText);
    DateTime today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    if (age < 18) return "You must be at least 18 years old";
    return "";
  } catch (_) {
    return "Invalid date format (expected yyyy-MM-dd)";
  }
}

String validatePhone(String phone) {
  final RegExp phoneRegExp = RegExp(r'^(010|011|012|015)[0-9]{8}$');
  if (phone.isEmpty) return "Phone number cannot be empty";
  if (!phoneRegExp.hasMatch(phone)) {
    return "Enter a valid Egyptian phone number";
  }
  return "";
}

String validateNationalId(String id) {
  final RegExp idRegExp = RegExp(r'^[23]\d{13}$');
  if (id.isEmpty) return "National ID cannot be empty";
  if (!idRegExp.hasMatch(id)) {
    return "National ID must be 14 digits and start with 2 or 3";
  }

  String centuryDigit = id.substring(0, 1);
  String year = id.substring(1, 3);
  String month = id.substring(3, 5);
  String day = id.substring(5, 7);
  String fullYear = (centuryDigit == '2' ? '19' : '20') + year;

  try {
    DateTime dob = DateTime.parse('$fullYear-$month-$day');
    int age = DateTime.now().difference(dob).inDays ~/ 365;
    if (age < 18) return "You must be at least 18 years old";
  } catch (_) {
    return "Invalid birth date in National ID";
  }

  return "";
}

String validateGovernment(String government) {
  if (government.trim().isEmpty) return 'Government is required';
  if (government.length < 2) return 'Government name is too short';
  return '';
}

String validateCity(String city) {
  if (city.trim().isEmpty) return 'City is required';
  if (city.length < 2) return 'City name is too short';
  return '';
}

String validateStreet(String street) {
  if (street.trim().isEmpty) return 'Street is required';
  return '';
}

String validateBuildingNumber(String building) {
  if (building.trim().isEmpty) return 'Building number is required';
  final number = int.tryParse(building);
  if (number == null || number <= 0) {
    return 'Building number must be a positive integer';
  }
  return '';
}

String? validateFloor(String floor) {
  if (floor.trim().isEmpty) return null; // Optional field
  final number = int.tryParse(floor);
  if (number == null || number < 0) {
    return 'Floor must be a non-negative number';
  }
  return null;
}

String? validateApartmentNumber(String apartment) {
  if (apartment.trim().isEmpty) return null; // Optional field
  final number = int.tryParse(apartment);
  if (number == null || number <= 0) {
    return 'Apartment number must be a positive number';
  }
  return null;
}

// Field Types
enum FieldType {
  name,
  email,
  password,
  confirmPassword,
  dob,
  phone,
  nationalId,
  username
}

// Unified validator
String validateField(FieldType type, String value) {
  switch (type) {
    case FieldType.name:
      return validateName(value);
    case FieldType.email:
      return validateEmail(value);
    case FieldType.password:
      return validateRegisterPassword(value);
    case FieldType.confirmPassword:
      return validateConfirmPass(value);
    case FieldType.dob:
      return validateDOB(value);
    case FieldType.phone:
      return validatePhone(value);
    case FieldType.nationalId:
      return validateNationalId(value);
    case FieldType.username:
      return validateUsername(value);
  }
}
