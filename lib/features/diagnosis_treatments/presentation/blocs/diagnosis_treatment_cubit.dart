import 'package:bloc/bloc.dart';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/diagnosis_treatments/data/diagnosis.dart';
import 'package:cloud_medix/features/diagnosis_treatments/data/treatment.dart';
import 'package:cloud_medix/features/diagnosis_treatments/domain/diagnosis_treatment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'diagnosis_treatment_state.dart';

class DiagnosisTreatmentCubit extends Cubit<DiagnosisTreatmentState> {
  DiagnosisTreatmentCubit() : super(DiagnosisTreatmentInitial());
  List<Treatment> treatments = [];
  List<Diagnosis> diagnosis = [];

  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  final DiagnosisTreatmentRepository repo =
      getIt<DiagnosisTreatmentRepository>();

  int selectedtabIndex = 0;

  /// Call this method explicitly in the UI, instead of constructor if you want more control
  Future<void> getMyDiagnosis() async {
    emit(DiagnosisTreatmentLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const DiagnosisTreatmentError("User ID is missing Error"));
      return;
    } else {
      ApiResponse response = await repo.getPatientDiagnosis(id);
      if (response.status == 200 && response.data != null) {
        diagnosis = response.data;
        emit(DiagnosisLoaded(diagnosis));
      } else {
        diagnosis = [];
        emit(DiagnosisTreatmentError(
            response.error ?? "No medical record available."));
      }
    }
  }

  Future<void> getMyTreatments() async {
    emit(DiagnosisTreatmentLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const DiagnosisTreatmentError("User ID is missing Error"));
      return;
    } else {
      ApiResponse response = await repo.getPatientTreatment(id);
      if (response.status == 200 && response.data != null) {
        treatments = response.data;

        emit(TreatmentLoaded(treatments));
      } else {
        treatments = [];
        emit(DiagnosisTreatmentError(
            response.error ?? "No medical record available."));
      }
    }
  }

  void changeTab(int index) {
    if (index == selectedtabIndex) return; // prevent reload of same tab

    selectedtabIndex = index;
    emit(DiagnosisTreatmentLoading());

    if (index == 0) {
      getMyDiagnosis();
    } else {
      getMyTreatments();
    }
  }
}
