import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/empty_state.json', width: 300.sp, height: 300.sp),
        Text(message, style: TextStyles.errormessage)
      ],
    );
  }
}
