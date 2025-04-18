import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({
    super.key,
    required this.title,
    this.isSettings = false, // optional with default
  });

  final String title;
  bool isSettings = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.primaryColor,
      actions: [
        isSettings
            ? IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
                  await storage.deleteAll();
                  if (context.mounted) {
                    Navigator.popAndPushNamed(context, Routes.login);
                  }
                },
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: SvgPicture.asset('assets/images/user.svg'),
              ),
      ],
      title: Text(title),
      titleTextStyle: TextStyles.appBarTexts,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_left_rounded,
          size: 60.sp,
          weight: 5,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
