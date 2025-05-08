import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_text_field.dart';
import 'package:cloud_medix/features/reservation/blocs/reservation_cubit.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/filter_option.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/reservation_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataBody extends StatelessWidget {
  const DataBody({
    super.key,
    required this.slots,
    required this.showOverlayLoader,
  });

  final List<Slot> slots;
  final bool showOverlayLoader;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w, right: 5.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 0.55.sw,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: MyAppTextField(
                        hintText: "Doctor",
                        onChanged: (value) {
                          context.read<ReservationCubit>().searchDoctor(value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 0.55.sw,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: MyAppTextField(
                        hintText: "Department",
                        onChanged: (value) {
                          context
                              .read<ReservationCubit>()
                              .searchDepartment(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 25.w),
              Expanded(child: FilterOption()),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: RefreshIndicator(
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
          ),
        ),
      ],
    );
  }
}
