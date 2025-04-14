import 'package:bloc/bloc.dart';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/medical_record/data/medical_record.dart';
import 'package:cloud_medix/features/medical_record/domain/medical_record_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'medical_record_state.dart';

class MedicalRecordCubit extends Cubit<MedicalRecordState> {
  MedicalRecordCubit() : super(MedicalRecordInitial());

  final List<String> categories = ["Allergies", "Diseases", "Medications"];
  List<List<dynamic>> medicalRecordLists = [];
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  final MedicalRecordRepository repo = getIt<MedicalRecordRepository>();
  late MedicalRecord medicalRecord;

  int selectedtabIndex = 0;

  /// Call this method explicitly in the UI, instead of constructor if you want more control
  Future<void> getMedRecord() async {
    emit(MedicalRecordLoading());
    String? id = await storage.read(key: "id");
    // const String id = "23de4037-51d9-490b-922f-7fc69056e8b1";

    if (id == null) {
      emit(const MedicalRecordError("User ID is missing Error"));
      return;
    } else {
      ApiResponse response = await repo.getMyMedicalRecord(id);
      if (response.status == 200 && response.data != null) {
        medicalRecord = response.data;
        medicalRecordLists
          ..clear()
          ..add(medicalRecord.allergies)
          ..add(medicalRecord.chronics)
          ..add(medicalRecord.currentMedications);

        emit(MedicalRecordLoaded(medicalRecord));
      } else {
        medicalRecordLists = [];
        emit(MedicalRecordError(
            response.error ?? "No medical record available."));
      }
    }
  }

  void changeTab(int index) {
    selectedtabIndex = index;
    emit(MedicalRecordLoading());
    if (medicalRecordLists.isNotEmpty) {
      emit(MedicalRecordLoaded(medicalRecord));
    } else {
      emit(MedicalRecordError("No medical record available."));
    }
  }
}
