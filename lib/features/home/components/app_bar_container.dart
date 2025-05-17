import 'package:cloud_medix/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({
    super.key,
    required this.image,
    required this.data,
  });
  final String image;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 90.w,
      decoration: BoxDecoration(
          color: ColorsManager.secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12.sp))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitHeight,
              child: SvgPicture.asset(
                image,
                width: 45.w,
                height: 45.h,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 3.h),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  data,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
