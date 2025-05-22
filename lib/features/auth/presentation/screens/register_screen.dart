import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/Register.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
              child: Card(
                color: Colors.white.withAlpha((0.9 * 255).toInt()),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      buildTextField(nameController, 'Full Name'),
                      buildTextField(usernameController, 'Username'),
                      buildTextField(nationalIdController, 'National ID',
                          TextInputType.number),
                      buildBirthdateField(context),
                      buildTextField(
                          phoneController, 'Phone Number', TextInputType.phone),
                      buildGenderDropdown(),
                      buildTextField(
                          emailController, 'Email', TextInputType.emailAddress),
                      buildTextField(passController, 'Password',
                          TextInputType.visiblePassword, true),
                      buildTextField(confirmPassController, 'Confirm Password',
                          TextInputType.visiblePassword, true),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () => onRegisterNextPressed(context),
                        child: const Text('Next',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Already have an account? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(Routes.login);
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: ColorsManager.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
