import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/make_reservation/presentation/components/reservation_button.dart';
import 'package:cloud_medix/features/make_reservation/presentation/components/reservation_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationRow extends StatelessWidget {
  const ReservationRow({
    super.key,
    required this.index,
    required this.slot,
    required this.buttonFunc,
  });
  final int index;
  final Slot slot;
  final VoidCallback buttonFunc;
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
                  color: ColorsManager.darkgreyColor),
            ),
            ReservationSlot(slot: slot),
            const Spacer(),
            ReservationButton(
              id: slot.id,
              func: buttonFunc,
              isReserved: slot.reserved,
            ),
          ],
        ),
      ),
    );
  }
}
