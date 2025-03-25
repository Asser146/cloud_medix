import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:cloud_medix/features/auth/presentation/screens/login_screen.dart';
import 'package:cloud_medix/features/auth/presentation/screens/register_screen.dart';
import 'package:cloud_medix/features/home/home_screen.dart';
import 'package:cloud_medix/features/make_reservation/presentation/blocs/reserve_status_cubit.dart';
import 'package:cloud_medix/features/make_reservation/presentation/make_reservation_screen.dart';
import 'package:cloud_medix/features/medical_record/blocs/medical_record_cubit.dart';
import 'package:cloud_medix/features/medical_record/view_medical_record.dart';
import 'package:cloud_medix/features/my_reservations/my_reservations_screen.dart';
import 'package:cloud_medix/features/tests_scan_results/tests_scan_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: const LoginScreen(),
                ));
      case Routes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: const RegisterScreen(),
                ));
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.viewMedicalRecord:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MedicalRecordCubit(),
                  child: const ViewMedicalRecord(),
                ));
      case Routes.testsScanResults:
        return MaterialPageRoute(builder: (_) => const TestsScanResults());
      case Routes.makeReservation:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ReservationCubit(),
                  child: const MakeReservationScreen(),
                ));
      case Routes.myReservations:
        return MaterialPageRoute(builder: (_) => const MyReservationsScreen());

      default:
        return null;
    }
  }
}
