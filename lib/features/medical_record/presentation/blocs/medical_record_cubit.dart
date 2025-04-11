import 'package:bloc/bloc.dart';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/medical_record/data/medical_record.dart';
import 'package:cloud_medix/features/medical_record/domain/medical_record_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'medical_record_state.dart';

class MedicalRecordCubit extends Cubit<MedicalRecordState> {
  MedicalRecordCubit() : super(MedicalRecordInitial()) {
    getMedRecord();
  }
  final categories = ["Allergies", "Diseases", "Medications"];

  late ApiResponse response;
  final MedicalRecordRepository repo = getIt<MedicalRecordRepository>();
  late MedicalRecord medicalRecord;
  // final storage = const FlutterSecureStorage();
  final List<List<dynamic>> medicalRecordLists =
      []; // Fixed to store lists of records
  int selectedtabIndex = 0;

  void changeTab(int index) {
    emit(MedicalRecordLoading());
    selectedtabIndex = index;
    emit(MedicalRecordLoaded(medicalRecord)); // Re-emit the updated state
  }

  Future<void> getMedRecord() async {
    emit(MedicalRecordLoading());
    // String? id = await storage.read(key: "id");
    String id = "23de4037-51d9-490b-922f-7fc69056e8b1";
    if (id != null) {
      try {
        response = await repo.getMyMedicalRecord(id);
        if (response.status == 200) {
          medicalRecord = response.data;
          medicalRecordLists.add(medicalRecord.allergies);
          medicalRecordLists.add(medicalRecord.chronics);
          medicalRecordLists.add(medicalRecord.currentMedications);
          emit(MedicalRecordLoaded(medicalRecord));
        } else {
          emit(const MedicalRecordError("No medicalRecord available."));
          return;
        }
      } on DioException catch (e) {
        MedicalRecordError(
            "Dio Error,Failed to load medicalRecord: ${e.toString()}");
      } catch (e) {
        MedicalRecordError("Failed to load medicalRecord: ${e.toString()}");
      }
    } else {
      emit(const MedicalRecordError("Id Error"));
    }
  }
}
