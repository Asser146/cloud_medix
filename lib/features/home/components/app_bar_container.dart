import 'package:cloud_medix/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({
    super.key,
    required this.image,
    required this.data,
    required this.type,
  });
  final String image;
  final String data;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 80.w,
      decoration: BoxDecoration(
          color: ColorsManager.secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12.sp))),
      child: type == 3
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: SvgPicture.asset(
                      image,
                      width: 45.w,
                      height: 40.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      image,
                      width: 45.w,
                      height: 40.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      data,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
