import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 35.h,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          child: Center(
            child: state is AuthLoading
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: const FittedBox(
                      fit: BoxFit.fitHeight,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      if (await context.read<AuthCubit>().login()) {
                        if (context.mounted) {
                          Navigator.pushNamed(context, Routes.home);
                        } else {
                          return;
                        }
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyles.testName,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
