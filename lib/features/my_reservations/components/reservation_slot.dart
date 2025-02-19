import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationSlot extends StatelessWidget {
  const ReservationSlot({
    super.key,
    required this.isOdd,
  });
  final bool isOdd;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70.h,
        width: 0.6 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r)),
          color: isOdd
              ? ColorsManager.lightCyanColor
              : ColorsManager.lightgreyColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("08:00 - 08:15", style: TextStyles.slotDuration),
              Text("Doctor XYZ", style: TextStyles.doctorName),
              Text("ABC Hospital", style: TextStyles.hospitalName),
            ],
          ),
        ));
  }
}
