import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    usernameController.clear();
    passController.clear();
    return GestureDetector(
      onTap: () async {
        // Close the keyboard first
        // FocusScope.of(context).unfocus();

        final username = usernameController.text.trim();
        final password = passController.text.trim();

        String usernameError = validateUsername(username);
        String passwordError = validateRegisterPassword(password);

        if (usernameError.isNotEmpty || passwordError.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                usernameError.isNotEmpty ? usernameError : passwordError,
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        if (await context.read<AuthCubit>().login(username, password)) {
          if (context.mounted) {
            Navigator.pushNamed(context, Routes.home);
          }
        } else {
          usernameController.clear();
          passController.clear();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login failed, Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 35.h,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Center(
          child: Text(
            'Login',
            style: TextStyles.testName,
          ),
        ),
      ),
    );
  }
}
