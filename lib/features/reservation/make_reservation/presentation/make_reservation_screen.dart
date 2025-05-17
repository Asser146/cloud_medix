import 'dart:developer';

import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/blocs/make_reservation_cubit.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/data_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class MakeReservationScreen extends StatelessWidget {
  const MakeReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MakeReservationCubit>();
    cubit.getSlots(false);

    return Scaffold(
      appBar: MyAppBar(title: "Make Reservation"),
      backgroundColor: ColorsManager.backgroundColor,
      body: BlocBuilder<MakeReservationCubit, MakeReservationState>(
        builder: (context, state) {
          List<Slot> slots = [];
          bool showOverlayLoader = false;

          if (state is MakeReservationLoaded) {
            slots = List<Slot>.from(state.list);
          } else if (state is MakeReservationProcessLoading) {
            slots = List<Slot>.from(state.list);
            showOverlayLoader = true;
          } else if (state is MakeReservationLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is MakeReservationError) {
            return Center(child: MyErrorWidget(message: state.message));
          }
          return DataBody(slots: slots, showOverlayLoader: showOverlayLoader);
        },
      ),
    );
  }
}
