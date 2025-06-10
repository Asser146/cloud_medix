import 'package:json_annotation/json_annotation.dart';
part 'allergy.g.dart';

@JsonSerializable()
class Allergy {
  int medicalRecordId;
  String code;
  String notes;
  String description;

  Allergy({
    required this.medicalRecordId,
    required this.code,
    required this.notes,
    required this.description,
  });
  Map<String, dynamic> toJson() => _$AllergyToJson(this);
  factory Allergy.fromJson(Map<String, dynamic> json) =>
      _$AllergyFromJson(json);
}
