import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/input_text_field.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Stack(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
                          style: TextStyles.welcomBack
                              .copyWith(color: Colors.cyan)),
                      SizedBox(height: 10.h),
                      InputTextField(
                        title: "Username",
                        isPass: false,
                        controller: usernameController,
                      ),
                      SizedBox(height: 12.h),
                      InputTextField(
                        title: "Password",
                        isPass: true,
                        controller: passController,
                      ),
                      SizedBox(height: 20.h),
                      const LoginButton(),
                    ],
                  ),
                ),
              ),
              if (state is AuthLoading)
                Positioned.fill(
                  child: Container(
                    color: const Color.fromARGB(
                        102, 211, 197, 248), // 40% opacity lilac
                    child: const Center(child: LoadingWidget()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
