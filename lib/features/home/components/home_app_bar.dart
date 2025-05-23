import 'dart:convert';
import 'dart:io';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/home/components/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.height, required this.userName});
  final double height;
  final String userName;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _HomeAppBarState extends State<HomeAppBar> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadUserImage(); // move everything into here
  }

  Future<void> _loadUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    final storage = getIt<FlutterSecureStorage>();
    final userId = await storage.read(key: "id");

    if (userId != null) {
      final rawMap = prefs.getString("user_image_map");
      if (rawMap != null) {
        final map = Map<String, dynamic>.from(jsonDecode(rawMap));
        final imagePath = map[userId];
        if (imagePath != null && File(imagePath).existsSync()) {
          // set file for internal use
          setState(() {
            _selectedImage = File(imagePath);
          });

          // ✅ update notifier so ValueListenableBuilder rebuilds
          getIt<ValueNotifier<String?>>().value = imagePath;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userImageNotifier = getIt<ValueNotifier<String?>>();
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
            color: ColorsManager.primaryColor,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder<String?>(
                  valueListenable: userImageNotifier,
                  builder: (context, imagePath, _) {
                    File? userImageFile;
                    if (imagePath != null && File(imagePath).existsSync()) {
                      userImageFile = File(imagePath);
                    }

                    return CircleAvatar(
                      radius: 50.sp,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: userImageFile != null
                          ? FileImage(userImageFile)
                          : null,
                      child: userImageFile == null
                          ? SvgPicture.asset('assets/images/user.svg')
                          : null,
                    );
                  },
                ),
                SizedBox(height: 5.h),
                Text(
                  widget.userName,
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
                        image: 'assets/images/height.svg', data: '180'),
                    AppBarContainer(
                        image: 'assets/images/bmi.svg',
                        data: "BMI: ${bmi.toStringAsFixed(2)}"),
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
              Navigator.pushNamed(context, Routes.settings);
            },
          ),
        ),
      ],
    );
  }
}
