import 'package:cloud_medix/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: 0.25 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorsManager.midcyanColors,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: const Center(child: Text("+Reserve")),
    );
  }
}
