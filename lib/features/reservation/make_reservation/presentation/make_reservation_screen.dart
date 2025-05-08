import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/data_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/reservation/blocs/reservation_cubit.dart';
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
      body: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
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
            return Center(child: MyErrorWidget(message: state.message));
          }

          if (slots.isEmpty) {
            return const Center(
              child: Text(
                "No available slots.",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            );
          }

          return DataBody(slots: slots, showOverlayLoader: showOverlayLoader);
        },
      ),
    );
  }
}
