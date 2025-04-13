import 'package:bloc/bloc.dart';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/medical_record/data/medical_record.dart';
import 'package:cloud_medix/features/medical_record/domain/medical_record_repository.dart';
import 'package:equatable/equatable.dart';

part 'medical_record_state.dart';

class MedicalRecordCubit extends Cubit<MedicalRecordState> {
  MedicalRecordCubit() : super(MedicalRecordInitial());

  final List<String> categories = ["Allergies", "Diseases", "Medications"];
  final List<List<dynamic>> medicalRecordLists = [];

  final MedicalRecordRepository repo = getIt<MedicalRecordRepository>();

  late MedicalRecord medicalRecord;
  late ApiResponse response;
  int selectedtabIndex = 0;

  /// Call this method explicitly in the UI, instead of constructor if you want more control
  Future<void> getMedRecord() async {
    emit(MedicalRecordLoading());

    // TODO: Replace with secure storage later
    const String id = "23de4037-51d9-490b-922f-7fc69056e8b1";

    if (id.isEmpty) {
      emit(const MedicalRecordError("User ID is missing."));
      return;
    }

    response = await repo.getMyMedicalRecord(id);

    if (response.status == 200 && response.data != null) {
      medicalRecord = response.data;
      medicalRecordLists
        ..clear()
        ..add(medicalRecord.allergies)
        ..add(medicalRecord.chronics)
        ..add(medicalRecord.currentMedications);

      emit(MedicalRecordLoaded(medicalRecord));
    } else {
      emit(
          MedicalRecordError(response.error ?? "No medical record available."));
    }
  }

  void changeTab(int index) {
    selectedtabIndex = index;
    emit(MedicalRecordLoading());
    emit(MedicalRecordLoaded(medicalRecord)); // Re-emit to reflect tab change
  }
}
