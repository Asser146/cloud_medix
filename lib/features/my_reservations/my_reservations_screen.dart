import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/make_reservation/components/reservation_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "My Reservations"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.w),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ReservationRow(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
