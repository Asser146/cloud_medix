import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/blocs/make_reservation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton({
    super.key,
    required this.id,
    required this.isReserved,
  });
  final int id;
  final bool isReserved;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isReserved) {
          context.read<MakeReservationCubit>().reserveSlot(id);
        }
      },
      child: Container(
        height: 55.h,
        width: 0.25 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isReserved ? Colors.grey : ColorsManager.midcyanColors,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
            child: isReserved ? const Text("Reserved") : const Text("Reserve")),
      ),
    );
  }
}
