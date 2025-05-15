import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ServerErrorWidget extends StatelessWidget {
  const ServerErrorWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('assets/server_error_state.json',
            width: 200.sp, height: 200.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            message,
            style: TextStyles.errormessage,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
