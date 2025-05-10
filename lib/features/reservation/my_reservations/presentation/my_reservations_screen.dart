import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:cloud_medix/features/reservation/my_reservations/presentation/blocs/my_reservations_cubit.dart';
import 'package:cloud_medix/features/reservation/my_reservations/presentation/components/reservation_row.dart';
import 'package:flutter/material.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MyReservationsCubit>().getMyReservationss();

    return Scaffold(
      appBar: MyAppBar(title: "My Reservations"),
      backgroundColor: ColorsManager.backgroundColor,
      body: BlocBuilder<MyReservationsCubit, MyReservationsState>(
        builder: (context, state) {
          // Extract MyReservations if available
          List<MyReservation> reservations = [];
          bool showOverlayLoader = false;
          if (state is MyReservationsLoaded) {
            reservations = List<MyReservation>.from(state.list);
          } else if (state is MyReservationsProcessLoading) {
            reservations = List<MyReservation>.from(state.list);
            showOverlayLoader = true;
          } else if (state is MyReservationsLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is MyReservationsError) {
            return Center(child: MyErrorWidget(message: state.message));
          }

          if (reservations.isEmpty) {
            return const Center(
              child: Text("No available MyReservations.",
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
                    reservation: reservations[index],
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
