import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/my_app_text_field.dart';
import 'package:cloud_medix/features/reservation/blocs/reservation_cubit.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/filter_option.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/data_body.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class MakeReservationScreen extends StatelessWidget {
  const MakeReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reservationCubit = context.read<ReservationCubit>();
    reservationCubit.getSlots(false);

    return Scaffold(
      appBar: MyAppBar(title: "Make Reservation"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 5.w, right: 5.w),
            child: Row(
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
                            context
                                .read<ReservationCubit>()
                                .searchDoctor(value);
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
                Expanded(child: FilterOption())
              ],
            ),
          ),
          SizedBox(height: 15.h),
          const DataBody(),
        ],
      ),
    );
  }
}
