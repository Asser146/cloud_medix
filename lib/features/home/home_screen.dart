import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/home/components/home_app_bar.dart';
import 'package:cloud_medix/features/home/components/home_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      appBar: HomeAppBar(
        height: 0.32 * MediaQuery.of(context).size.height,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.viewMedicalRecord),
                child: const HomeOption(
                  text: "View Medical Record",
                  path: "assets/images/medical_record.svg",
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.testsScanResults),
                child: const HomeOption(
                    text: "Tests/Scans Results",
                    path: "assets/images/home_container1.svg"),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.makeReservation),
                child: const HomeOption(
                    text: "Make Reservation",
                    path: "assets/images/make_reservation.svg"),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.myReservations),
                child: const HomeOption(
                    text: "My Reservations",
                    path: "assets/images/my_reservations.svg"),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.diagnosisTreatments),
                child: const HomeOption(
                    text: "Diagnosis/Treatments",
                    path: "assets/images/protect.svg"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
