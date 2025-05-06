import 'package:json_annotation/json_annotation.dart';

part 'diagnosis.g.dart';

@JsonSerializable()
class Diagnosis {
  String type;
  String description;
  String hospitalName;
  String issuedDate;
  String physicianFullname;

  Diagnosis({
    required this.type,
    required this.description,
    required this.hospitalName,
    required this.issuedDate,
    required this.physicianFullname,
  });

  Map<String, dynamic> toJson() => _$DiagnosisToJson(this);
  factory Diagnosis.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFromJson(json);
}
