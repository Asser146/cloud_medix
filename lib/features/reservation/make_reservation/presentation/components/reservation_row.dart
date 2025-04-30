import 'dart:developer';

import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/reservation_button.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/reservation_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationRow extends StatelessWidget {
  const ReservationRow({
    super.key,
    required this.index,
    required this.slot,
    required this.isMyReservations,
    this.resId,
  });
  final int? resId;
  final int index;
  final Slot slot;
  final bool isMyReservations;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
            id: isMyReservations ? resId! : slot.id,
            isReserved: slot.reserved,
            isMyReservations: isMyReservations,
          ),
        ],
      ),
    );
  }
}
