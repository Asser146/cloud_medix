import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/home/components/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                // SizedBox(height: 25.h), // Adjust spacing for avatar
                SvgPicture.asset(
                  'assets/images/user.svg', // Ensure the path is correct
                  width: 90.w, // Responsive width using screenutil
                  height: 90.h, // Responsive height
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 5.h),
                Text(
                  'UserName',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppBarContainer(
                        image: 'assets/images/weight.svg', data: '74'),
                    AppBarContainer(
                        image: 'assets/images/height.svg', data: '180'),
                    AppBarContainer(
                        image: 'assets/images/signout.svg', data: 'log out'),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(230.h);
}
