import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/make_reservation/presentation/blocs/make_reservation_cubit.dart';
import 'package:cloud_medix/features/make_reservation/presentation/components/reservation_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataBody extends StatelessWidget {
  const DataBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MakeReservationCubit, MakeReservationState>(
        builder: (context, state) {
          // Extract slots if available
          List<Slot> slots = [];
          bool showOverlayLoader = false;

          if (state is MakeReservationLoaded) {
            slots = state.slots;
          } else if (state is MakeReservationReserveLoading) {
            slots = state.slots;
            showOverlayLoader = true;
          } else if (state is MakeReservationLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is MakeReservationError) {
            return MyErrorWidget(message: state.message);
          }

          if (slots.isEmpty) {
            return const Center(
              child: Text("No available slots.",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            );
          }

          return Stack(
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
                      buttonFunc: () => context
                          .read<MakeReservationCubit>()
                          .reserveSlot(slots[index].id),
                    );
                  },
                ),
              ),
              if (showOverlayLoader) const Center(child: LoadingWidget()),
            ],
          );
        },
      ),
    );
  }
}
