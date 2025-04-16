import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/make_reservation/presentation/components/reservation_row.dart';
import 'package:cloud_medix/features/my_reservations/presentation/blocs/my_reservations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "My Reservations"),
      backgroundColor: ColorsManager.backgroundColor,
      body: BlocBuilder<MyReservationsCubit, MyReservationState>(
        builder: (context, state) {
          if (state is MyReservationsLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is MyReservationsError) {
            return Center(child: MyErrorWidget(message: state.message));
          } else if (state is MyReservationsLoaded) {
            if (state.reservations.isEmpty) {
              return const Center(
                child: Text(
                  "No Reservations Done.",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(10.w),
              itemCount: state.reservations.length,
              itemBuilder: (context, index) {
                return ReservationRow(
                    index: index, slot: state.reservations[index].slot);
              },
            );
          } else {
            return const Center(
              child: MyErrorWidget(
                  message: "SomeThing Went Wrong\nTry again Later"),
            );
          }
        },
      ),
    );
  }
}
