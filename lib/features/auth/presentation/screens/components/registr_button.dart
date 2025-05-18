import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.login);
      },
      child: Container(
        width: double.infinity,
        height: 35.h,
        decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Center(
          child: Text(
            'Register',
            style: TextStyles.testName,
          ),
        ),
      ),
    );
  }
}
