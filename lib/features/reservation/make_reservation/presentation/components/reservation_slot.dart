import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReservationSlot extends StatelessWidget {
  const ReservationSlot({
    super.key,
    required this.slot,
  });
  final Slot slot;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75.h,
        width: 0.6 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r)),
          color: ColorsManager.lightgreyColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${DateFormat.Hm().format(DateTime.parse(slot.startTime.toString()))} - ${DateFormat.Hm().format(DateTime.parse(slot.endTime.toString()))}",
                  style: TextStyles.slotDuration),
              Text(slot.physicianFullName, style: TextStyles.doctorName),
              Text(slot.specialtyName, style: TextStyles.hospitalName),
            ],
          ),
        ));
  }
}
