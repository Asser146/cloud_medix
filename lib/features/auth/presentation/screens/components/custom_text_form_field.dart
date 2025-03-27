import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.type,
      required this.fieldController});
  final String hintText;
  final int type;
  final TextEditingController fieldController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: TextFormField(
        controller: fieldController,
        cursorColor: ColorsManager.secondaryColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          hintText: hintText,
          hintStyle: TextStyles.authField,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: const BorderSide(
              color: ColorsManager.thirdColor,
              width: 2.0,
            ),
          ),
        ),
        validator: (value) {
          String response = validateField(type, fieldController.text);
          if (response.isNotEmpty) {
            return response;
          }
          return null;
        },
      ),
    );
  }
}
