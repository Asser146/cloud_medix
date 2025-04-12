import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/home/components/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.height});
  final double height;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const AppBarContainer(
                        image: 'assets/images/weight.svg', data: '74', type: 1),
                    const AppBarContainer(
                      image: 'assets/images/height.svg',
                      data: '180',
                      type: 2,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final navigator =
                            Navigator.of(context); // capture before async
                        final storage = getIt<FlutterSecureStorage>();
                        await storage.deleteAll();
                        navigator.popAndPushNamed(Routes.login); // safe!
                      },
                      child: AppBarContainer(
                          image: 'assets/images/signout.svg',
                          data: 'log out',
                          type: 3),
                    ),
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
  Size get preferredSize => Size.fromHeight(height);
}
