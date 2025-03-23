import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        const InputTextField(title: "Username"),
        SizedBox(height: 15.h),
        const InputTextField(title: "Full Name"),
        SizedBox(height: 15.h),
        const InputTextField(title: "Email"),
        SizedBox(height: 15.h),
        const InputTextField(title: "Password"),
        SizedBox(height: 15.h),
        const InputTextField(title: "Confirm Password"),
        SizedBox(height: 20.h),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isFirstForm = false; // Switch to the second form
            });
          },
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
        const InputTextField(title: "Phone Number"),
        SizedBox(height: 12.h),
        const InputTextField(title: "National ID"),
        SizedBox(height: 12.h),
        const InputTextField(title: "Date of Birth"),
        SizedBox(height: 20.h),
        Container(
            width: double.infinity,
            height: 35.h,
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                child: Text(
                  'Register',
                  style: TextStyles.testName,
                ),
              ),
            )),
      ],
    );
  }
}
