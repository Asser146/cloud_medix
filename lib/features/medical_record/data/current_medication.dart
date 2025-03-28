import 'package:json_annotation/json_annotation.dart';
part 'current_medication.g.dart';

@JsonSerializable()
class CurrentMedication {
  int medicalRecordId;
  String name;
  int dose;
  DateTime startDate;
  DateTime endDate;

  CurrentMedication({
    required this.medicalRecordId,
    required this.name,
    required this.dose,
    required this.startDate,
    required this.endDate,
  });
  Map<String, dynamic> toJson() => _$CurrentMedicationToJson(this);
  factory CurrentMedication.fromJson(Map<String, dynamic> json) =>
      _$CurrentMedicationFromJson(json);
}
