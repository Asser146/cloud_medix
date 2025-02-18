import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/make_reservation/components/filter_option.dart';
import 'package:cloud_medix/features/make_reservation/components/reservation_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class MakeReservationScreen extends StatelessWidget {
  const MakeReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Make Reservation"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterOption(),
                FilterOption(),
                FilterOption(),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.sp),
                  topRight: Radius.circular(14.sp),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(10.w),
                itemCount: 10, // Replace with actual data length
                itemBuilder: (context, index) {
                  return ReservationRow(index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
