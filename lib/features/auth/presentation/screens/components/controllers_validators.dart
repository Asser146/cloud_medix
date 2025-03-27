import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();
final TextEditingController dobController = TextEditingController();

String validateName(String name) {
  final RegExp nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
  if (name.isEmpty) {
    return "Name cannot be empty";
  }
  if (!nameRegExp.hasMatch(name)) {
    return "Name must contain only letters and spaces";
  }
  return "";
}

String validateEmail(String email) {
  final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  if (email.isEmpty) {
    return "Email cannot be empty";
  }
  if (!emailRegExp.hasMatch(email)) {
    return "Enter a valid email address";
  }
  return "";
}

String validateRegisterPassword(String password) {
  if (password.isEmpty) {
    return "Password cannot be empty";
  }
  if (password.length < 8) {
    return "Password must be at least 8 characters long";
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return "Password must contain at least one uppercase letter";
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return "Password must contain at least one lowercase letter";
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return "Password must contain at least one number";
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return "Password must contain at least one special character";
  }
  return "";
}

String validateConfirmPass(String password) {
  if (password.isEmpty) {
    return "Confirm Password cannot be empty";
  }
  if (password != passController.text) {
    return "Password mis-match";
  }
  return "";
}

String validateDOB(String dobText) {
  if (dobText.isEmpty) {
    return "Date of Birth cannot be empty";
  }
  DateTime dob = DateFormat('yyyy-MM-dd').parse(dobText);
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - dob.year;

  if (age < 4 ||
      (age == 4 &&
          currentDate.isBefore(dob.add(const Duration(days: 365 * 4))))) {
    return "You must be at least 4 years old";
  }
  return "";
}

String validateField(int type, String text) {
  switch (type) {
    case 0:
      return validateName(text);
    case 1:
      return validateEmail(text);
    case 2:
      return validateRegisterPassword(text);
    case 3:
      return validateConfirmPass(text);
    case 4:
      return validateDOB(text);
    default:
      return "Error Occurred";
  }
}
