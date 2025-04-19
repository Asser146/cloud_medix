import 'package:cloud_medix/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton(
      {super.key,
      required this.id,
      required this.func,
      required this.isReserved});
  final int id;
  final VoidCallback func;
  final bool isReserved;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        height: 55.h,
        width: 0.25 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isReserved ? Colors.red : ColorsManager.midcyanColors,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
            child: isReserved ? const Text("Reserved") : const Text("Reserve")),
      ),
    );
  }
}
