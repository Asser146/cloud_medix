import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/make_reservation/presentation/blocs/reserve_status_cubit.dart';
import 'package:cloud_medix/features/make_reservation/presentation/components/reservation_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataBody extends StatelessWidget {
  const DataBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          if (state is ReserveStatusLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(color: ColorsManager.primaryColor),
            );
          } else if (state is ReserveStatusError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            );
          } else if (state is ReserveStatusLoaded) {
            if (state.slots.isEmpty) {
              return const Center(
                child: Text(
                  "No available slots.",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              );
            }
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.sp),
                  topRight: Radius.circular(14.sp),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(10.w),
                itemCount: state.slots.length,
                itemBuilder: (context, index) {
                  return ReservationRow(index: index, slot: state.slots[index]);
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Something went wrong.",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }
}
