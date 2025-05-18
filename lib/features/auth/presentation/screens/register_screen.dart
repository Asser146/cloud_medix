import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/custom_dob.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/custom_text_form_field.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/registr_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isFirstForm = true; // Track which form to show

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/Register.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: 0.8.sw,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: const [
                  BoxShadow(
                    color: ColorsManager.thirdColor,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Create ", style: TextStyles.welcomBack),
                      Text("Account",
                          style: TextStyles.welcomBack
                              .copyWith(color: Colors.cyan))
                    ],
                  ),
                  SizedBox(height: 10.h),
                  if (_isFirstForm) _buildFirstForm() else _buildSecondForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // First Form UI
  Widget _buildFirstForm() {
    return Column(
      children: [
        // const InputTextField(title: "Username"),
        CustomTextFormField(
            hintText: 'UserName', type: 0, fieldController: nameController),
        SizedBox(height: 15.h),
        CustomTextFormField(
            hintText: 'Full Name', type: 0, fieldController: nameController),
        SizedBox(height: 15.h),
        CustomTextFormField(
            hintText: 'Email', type: 0, fieldController: emailController),
        SizedBox(height: 15.h),
        CustomTextFormField(
            hintText: 'Password', type: 0, fieldController: passController),
        SizedBox(height: 15.h),
        CustomTextFormField(
            hintText: 'Confrim Password',
            type: 0,
            fieldController: confirmPassController),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: () => setState(() {
            _isFirstForm = false; // Switch to the second form
          }),
          child: Container(
              width: double.infinity,
              height: 35.h,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: Center(
                child: Text(
                  'Next',
                  style: TextStyles.testName,
                ),
              )),
        ),
      ],
    );
  }

  // Second Form UI
  Widget _buildSecondForm() {
    return Column(
      children: [
        CustomTextFormField(
            hintText: 'Phone Number', type: 0, fieldController: nameController),
        SizedBox(height: 12.h),
        CustomTextFormField(
            hintText: 'National Id', type: 0, fieldController: nameController),
        SizedBox(height: 12.h),
        const CustomDOB(),
        SizedBox(height: 20.h),
        RegisterButton(context: context),
      ],
    );
  }
}
