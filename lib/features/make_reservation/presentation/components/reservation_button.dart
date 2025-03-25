import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/make_reservation/presentation/blocs/reserve_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ReservationCubit>().reserveSlot(id),
      child: Container(
        height: 55.h,
        width: 0.25 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.watch<ReservationCubit>().selected == true
              ? Colors.red
              : ColorsManager.midcyanColors,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
            child: context.watch<ReservationCubit>().selected == true
                ? Text("Reserved")
                : Text("Reserve")),
      ),
    );
  }
}
