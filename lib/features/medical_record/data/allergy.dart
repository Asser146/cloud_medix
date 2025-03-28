import 'package:json_annotation/json_annotation.dart';
part 'allergy.g.dart';

@JsonSerializable()
class Allergy {
  int medicalRecordId;
  String name;
  String type;
  String description;

  Allergy({
    required this.medicalRecordId,
    required this.name,
    required this.type,
    required this.description,
  });
  Map<String, dynamic> toJson() => _$AllergyToJson(this);
  factory Allergy.fromJson(Map<String, dynamic> json) =>
      _$AllergyFromJson(json);
}
