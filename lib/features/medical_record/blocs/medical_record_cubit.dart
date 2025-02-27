import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'medical_record_state.dart';

class MedicalRecordCubit extends Cubit<MedicalRecordState> {
  MedicalRecordCubit() : super(MedicalRecordInitial());
  final categories = ["Allergies", "Diseases", "Diagnosis", "Medications"];
  List<String> allergies = ["allergy-1", "allergy-2", "allergy-3"];
  List<String> diseases = ["diseases-1", "diseases-2", "diseases-3"];
  List<String> diagnosis = ["diagnosis-1", "diagnosis-2", "diagnosis-3"];
  List<String> medications = [
    "medications-1",
    "medications-2",
    "medications-3"
  ];
  int selectedtabIndex = 0;
  void changeTab(int index) {
    emit(MedicalRecordLoading());
    selectedtabIndex = index;
    emit(MedicalRecordTabChanged(tabIndex: selectedtabIndex));
  }

  List<String> getRecordData() {
    switch (selectedtabIndex) {
      case 0:
        return allergies;
      case 1:
        return diseases;
      case 2:
        return diagnosis;
      case 3:
        return medications;
      default:
        return allergies;
    }
  }
}
