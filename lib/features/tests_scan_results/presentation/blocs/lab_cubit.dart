import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_request.dart';
import 'package:cloud_medix/features/tests_scan_results/domain/lab_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'lab_state.dart';

class LabCubit extends Cubit<LabState> {
  LabCubit() : super(LabInitial()) {
    getTests();
    log("Hereee");
  }

  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  final LabRepository repo = getIt<LabRepository>();
  late List<TestRequest> tests;

  Future<void> getTests() async {
    emit(LabLoading());
    String? id = await storage.read(key: "id");
    log(id!);
    if (id == null) {
      emit(const LabError("User ID is missing Error"));
      return;
    } else {
      ApiResponse response = await repo.getMyTests(id);
      log(response.data.toString());
      if (response.status == 200 && response.data != null) {
        emit(LabLoaded(tests));
      } else {
        tests = [];
        emit(LabError(response.error ?? "No medical record available."));
      }
    }
  }
}
