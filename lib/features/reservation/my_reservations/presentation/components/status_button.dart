import 'package:cloud_medix/features/reservation/my_reservations/presentation/blocs/my_reservations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key,
    required this.id,
    required this.status,
  });
  final int id;
  final int status;

  @override
  Widget build(BuildContext context) {
    Container getButton(int status) {
      switch (status) {
        case 0:
          return Container(
            height: 55.h,
            width: 0.25 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 67, 54, 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: const Text("Cancel"),
            ),
          );
        case 1:
          return Container(
            height: 55.h,
            width: 0.25 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: const Text("Canceled"),
            ),
          );
        case 2:
          return Container(
            height: 55.h,
            width: 0.25 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: const Text("Completed"),
            ),
          );
        default:
          return Container(
            height: 55.h,
            width: 0.25 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: const Text("Canceled"),
            ),
          );
      }
    }

    return GestureDetector(
        onTap: () {
          if (status == 0) {
            //Reserved
            context.read<MyReservationsCubit>().cancelMyReservations(id);
          }
        },
        child: getButton(status));
  }
}
