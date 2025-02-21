import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/features/home/home_screen.dart';
import 'package:cloud_medix/features/make_reservation/make_reservation_screen.dart';
import 'package:cloud_medix/features/medical_record/view_medical_record.dart';
import 'package:cloud_medix/features/my_reservations/my_reservations_screen.dart';
import 'package:cloud_medix/features/tests_scan_results/tests_scan_results.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.viewMedicalRecord:
        return MaterialPageRoute(builder: (_) => const ViewMedicalRecord());
      case Routes.testsScanResults:
        return MaterialPageRoute(builder: (_) => const TestsScanResults());
      case Routes.makeReservation:
        return MaterialPageRoute(builder: (_) => const MakeReservationScreen());
      case Routes.myReservations:
        return MaterialPageRoute(builder: (_) => const MyReservationsScreen());

      default:
        return null;
    }
  }
}
