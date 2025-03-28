import 'package:cloud_medix/features/medical_record/data/allergy.dart';
import 'package:cloud_medix/features/medical_record/data/chronic.dart';
import 'package:cloud_medix/features/medical_record/data/current_medication.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medical_record.g.dart';

@JsonSerializable()
class MedicalRecord {
  int id;
  String patientId;
  List<Allergy> allergies;
  List<Chronic> chronics;
  List<CurrentMedication> currentMedications;

  MedicalRecord({
    required this.id,
    required this.patientId,
    required this.allergies,
    required this.chronics,
    required this.currentMedications,
  });
  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);
  factory MedicalRecord.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordFromJson(json);
}
