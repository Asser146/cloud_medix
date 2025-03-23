import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/input_text_field.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/login_button.dart';
import 'package:cloud_medix/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/Login.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: 0.75.sw,
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
                  Text("Welcome", style: TextStyles.welcomBack),
                  Text("Back",
                      style:
                          TextStyles.welcomBack.copyWith(color: Colors.cyan)),
                  SizedBox(height: 10.h),
                  const InputTextField(title: "Username"),
                  SizedBox(height: 12.h),
                  const InputTextField(title: "Password"),
                  SizedBox(height: 20.h),

                  // BlocBuilder to manage login button state
                  const LoginButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
