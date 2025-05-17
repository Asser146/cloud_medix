import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/home/components/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.height, required this.userName});
  final double height;
  final String userName;
  @override
  Widget build(BuildContext context) {
    double heightM = 180 / 100;
    double bmi = 70 / (heightM * heightM); // convert height to meters

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              color: ColorsManager.primaryColor),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(
                    'assets/images/user.svg',
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const AppBarContainer(
                        image: 'assets/images/weight.svg', data: '74'),
                    const AppBarContainer(
                      image: 'assets/images/height.svg',
                      data: '180',
                    ),
                    AppBarContainer(
                      image: 'assets/images/bmi.svg',
                      data: "BMI: ${bmi.toStringAsFixed(2)}",
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
        Positioned(
          top: 35.h,
          right: 16.w,
          child: IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 28.sp),
            onPressed: () {
              // Navigate to settings or perform your logic
              Navigator.pushNamed(
                  context, Routes.settings); // make sure this route exists
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
