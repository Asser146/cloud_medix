import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/make_reservation/blocs/cubit/reserve_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ReserveStatusCubit>().toggleSlot(),
      child: Container(
        height: 55.h,
        width: 0.25 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.watch<ReserveStatusCubit>().selected == true
              ? Colors.red
              : ColorsManager.midcyanColors,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Center(child: Text("+Reserve")),
      ),
    );
  }
}
