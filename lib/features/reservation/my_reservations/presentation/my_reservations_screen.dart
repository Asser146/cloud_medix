import 'package:cloud_medix/core/widgets/loading_widget.dart';

import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/reservation/blocs/reservation_cubit.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/reservation_row.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReservationCubit>().getReservations();

    return Scaffold(
      appBar: MyAppBar(title: "My Reservations"),
      backgroundColor: ColorsManager.backgroundColor,
      body: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          // Extract reservation if available
          List<MyReservation> reservations = [];
          bool showOverlayLoader = false;
          if (state is ReservationLoaded) {
            reservations = List<MyReservation>.from(state.list);
          } else if (state is ReservationProcessLoading) {
            reservations = List<MyReservation>.from(state.list);
            showOverlayLoader = true;
          } else if (state is ReservationLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is ReservationError) {
            return Center(child: MyErrorWidget(message: state.message));
          }

          if (reservations.isEmpty) {
            return const Center(
              child: Text("No available reservation.",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            );
          }

          return Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.all(10.w),
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  return ReservationRow(
                    index: index,
                    slot: reservations[index].slot,
                    isMyReservations: true,
                    resId: reservations[index].id,
                  );
                },
              ),
              if (showOverlayLoader) const Center(child: LoadingWidget()),
            ],
          );
        },
      ),
    );
  }
}
