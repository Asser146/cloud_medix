import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReservationData extends StatelessWidget {
  const ReservationData({
    super.key,
    required this.reservation,
  });
  final MyReservation reservation;
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
                  "${DateFormat.Hm().format(DateTime.parse(reservation.startTime.toString()))} - ${DateFormat.Hm().format(DateTime.parse(reservation.endTime.toString()))}",
                  style: TextStyles.slotDuration),
              Text(reservation.physicianName, style: TextStyles.doctorName),
              Text("Hospital: ${reservation.hospital.name}",
                  style: TextStyles.hospitalName),
            ],
          ),
        ));
  }
}
