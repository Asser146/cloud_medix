import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:cloud_medix/features/auth/presentation/screens/login_screen.dart';
import 'package:cloud_medix/features/auth/presentation/screens/register_screen.dart';
import 'package:cloud_medix/features/diagnosis_treatments/presentation/blocs/diagnosis_treatment_cubit.dart';
import 'package:cloud_medix/features/diagnosis_treatments/presentation/diagnosis_treatments.dart';
import 'package:cloud_medix/features/home/home_screen.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/blocs/make_reservation_cubit.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/make_reservation_screen.dart';
import 'package:cloud_medix/features/medical_record/presentation/blocs/medical_record_cubit.dart';
import 'package:cloud_medix/features/medical_record/view_medical_record.dart';
import 'package:cloud_medix/features/reservation/my_reservations/presentation/blocs/my_reservations_cubit.dart';
import 'package:cloud_medix/features/reservation/my_reservations/presentation/my_reservations_screen.dart';
import 'package:cloud_medix/features/settings/presentation/blocs/settings_cubit.dart';
import 'package:cloud_medix/features/settings/presentation/settings_screen.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/blocs/lab_cubit.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/tests_scan_results.dart';
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
      case Routes.settings:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SettingsCubit(),
                  child: const SettingsScreen(),
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
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LabCubit(),
                  child: const TestsScanResults(),
                ));
      case Routes.makeReservation:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MakeReservationCubit(),
                  child: const MakeReservationScreen(),
                ));
      case Routes.myReservations:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MyReservationsCubit(),
                  child: const MyReservationsScreen(),
                ));
      case Routes.diagnosisTreatments:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => DiagnosisTreatmentCubit(),
                  child: const DiagnosisTreatments(),
                ));
      default:
        return null;
    }
  }
}
