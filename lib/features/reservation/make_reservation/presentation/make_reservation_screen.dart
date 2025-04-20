import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/reservation/blocs/reservation_cubit.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/data_body.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/filter_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class MakeReservationScreen extends StatelessWidget {
  const MakeReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReservationCubit>().getSlots();
    return Scaffold(
      appBar: MyAppBar(title: "Make Reservation"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterOption(),
                FilterOption(),
                FilterOption(),
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
