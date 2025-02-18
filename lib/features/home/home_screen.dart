import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/home/components/home_app_bar.dart';
import 'package:cloud_medix/features/home/components/home_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      appBar: HomeAppBar(
        height: 0.32 * MediaQuery.of(context).size.height,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 3.h),
              const HomeOption(text: "View Medical Record"),
              const HomeOption(text: "Tests/Scans Results"),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.makeReservation),
                child: const HomeOption(text: "Make Reservation"),
              ),
              const HomeOption(text: "My Reservations"),
            ],
          ),
        ),
      ),
    );
  }
}
