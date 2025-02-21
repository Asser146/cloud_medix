import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/make_reservation/blocs/reserve_status_cubit.dart';
import 'package:cloud_medix/features/make_reservation/components/reservation_button.dart';
import 'package:cloud_medix/features/make_reservation/components/reservation_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationRow extends StatelessWidget {
  const ReservationRow({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReserveStatusCubit(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Align(
          alignment: Alignment.center, // This ensures it stays centered
          child: Row(
            children: [
              Container(
                height: 80.h,
                width: 8.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r)),
                  color: index % 2 == 0
                      ? ColorsManager.darkgreyColor
                      : ColorsManager.darkcyanColor,
                ),
              ),
              ReservationSlot(isOdd: index % 2 != 0 ? true : false),
              const Spacer(),
              const ReservationButton(),
            ],
          ),
        ),
      ),
    );
  }
}
