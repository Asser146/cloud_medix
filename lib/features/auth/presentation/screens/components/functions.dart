import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/auth/data/register_body.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField(TextEditingController controller, String label,
    [TextInputType keyboardType = TextInputType.text, bool isObscure = false]) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: ColorsManager.thirdColor.withAlpha((0.5 * 255).toInt()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

Widget buildBirthdateField(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: TextField(
      controller: birthdateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Birthdate',
        hintText: 'YYYY-MM-DD',
        filled: true,
        fillColor: ColorsManager.thirdColor.withAlpha((0.5 * 255).toInt()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          initialDate: DateTime(2000),
        );
        if (date != null) {
          birthdateController.text = date.toIso8601String().split('T').first;
        }
      },
    ),
  );
}

Widget buildGenderDropdown() {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: ValueListenableBuilder<String?>(
      valueListenable: genderNotifier,
      builder: (_, gender, __) {
        return DropdownButtonFormField<String>(
          value: gender,
          decoration: InputDecoration(
            labelText: 'Gender',
            filled: true,
            fillColor: ColorsManager.thirdColor.withAlpha((0.5 * 255).toInt()),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Male', child: Text('Male')),
            DropdownMenuItem(value: 'Female', child: Text('Female')),
          ],
          onChanged: (value) => genderNotifier.value = value,
        );
      },
    ),
  );
}

void onRegisterNextPressed(BuildContext context) {
  final errors = <String>[];

  final nameError = validateField(FieldType.name, nameController.text);
  final emailError = validateField(FieldType.email, emailController.text);
  final usernameError =
      validateField(FieldType.username, usernameController.text);
  final passwordError = validateField(FieldType.password, passController.text);
  final confirmPasswordError =
      validateField(FieldType.confirmPassword, confirmPassController.text);
  final dobError = validateField(FieldType.dob, birthdateController.text);
  final phoneError = validateField(FieldType.phone, phoneController.text);
  final nationalIdError =
      validateField(FieldType.nationalId, nationalIdController.text);
  final genderValue = genderNotifier.value;

  if (nameError.isNotEmpty) errors.add(nameError);
  if (emailError.isNotEmpty) errors.add(emailError);
  if (usernameError.isNotEmpty) errors.add(usernameError);
  if (passwordError.isNotEmpty) errors.add(passwordError);
  if (confirmPasswordError.isNotEmpty) errors.add(confirmPasswordError);
  if (dobError.isNotEmpty) errors.add(dobError);
  if (phoneError.isNotEmpty) errors.add(phoneError);
  if (nationalIdError.isNotEmpty) errors.add(nationalIdError);
  if (genderValue == null) errors.add("Gender must be selected");

  if (errors.isNotEmpty) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Validation Errors"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: errors.map((e) => Text("• $e")).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
    return;
  }

  final registerBody = RegisterBody(
    fullName: nameController.text,
    email: emailController.text,
    password: passController.text,
    userName: usernameController.text,
    date: birthdateController.text,
    phone: phoneController.text,
    nationalID: nationalIdController.text,
    gender: genderValue == 'Male' ? 0 : 1,
  );
  // final registerBody = RegisterBody(
  //     fullName: "Asser Tamer",
  //     email: "assora@gmail.com",
  //     password: "SecurePass123!",
  //     userName: "asssor",
  //     date: "2000-01-01",
  //     phone: "01234567890",
  //     nationalID: "12345678901234",
  //     gender: 0);

  Navigator.pushNamed(context, Routes.address, arguments: registerBody);
}
