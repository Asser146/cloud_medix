import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDOB extends StatelessWidget {
  const CustomDOB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: TextFormField(
        controller: dobController,
        readOnly: true, // Prevent manual input
        decoration: InputDecoration(
          hintText: 'Date of Birth',
          suffixIcon: const Icon(Icons.calendar_today),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
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
        onTap: () {},
        // onTap: () => context
        //     .read<RegisterCubit>()
        //     .selectDate(context, dobController), // Show date picker when tapped
        validator: (value) {
          String response = validateField(4, dobController.text);
          if (response.isNotEmpty) {
            return response;
          }
          return null;
        },
      ),
    );
  }
}
