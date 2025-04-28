import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/reservation/blocs/reservation_cubit.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/reservation_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataBody extends StatelessWidget {
  const DataBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          // Extract slots if available
          List<Slot> slots = [];
          bool showOverlayLoader = false;

          if (state is ReservationLoaded) {
            slots = List<Slot>.from(state.list);
          } else if (state is ReservationProcessLoading) {
            slots = List<Slot>.from(state.list);
            showOverlayLoader = true;
          } else if (state is ReservationLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is ReservationError) {
            return MyErrorWidget(message: state.message);
          }

          if (slots.isEmpty) {
            return const Center(
              child: Text("No available slots.",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Manual refresh triggers new slot fetch
              await context.read<ReservationCubit>().refreshSlots();
            },
            child: Stack(
              children: [
                Container(
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
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      return ReservationRow(
                        index: index,
                        slot: slots[index],
                        isMyReservations: false,
                      );
                    },
                  ),
                ),
                if (showOverlayLoader) const Center(child: LoadingWidget()),
              ],
            ),
          );
        },
      ),
    );
  }
}
