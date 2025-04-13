import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/error.png",
          width: 200.sp,
          height: 200.sp,
        ),
        Text(message)
      ],
    );
  }
}
