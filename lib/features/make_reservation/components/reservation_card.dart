import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/make_reservation/components/reservation_button.dart';
import 'package:cloud_medix/features/make_reservation/components/slot_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Align(
        alignment: Alignment.center, // This ensures it stays centered
        child: Row(
          children: [
            Container(
              height: 70.h,
              width: 8.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r)),
                color: ColorsManager.darkcyanColor,
              ),
            ),
            const SlotDetails(),
            const Spacer(),
            const ReservationButton(),
          ],
        ),
      ),
    );
  }
}
