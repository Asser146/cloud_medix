import 'package:json_annotation/json_annotation.dart';

part 'treatment.g.dart';

@JsonSerializable()
class Treatment {
  String type;
  String hospitalName;
  DateTime issuedDate;
  String physicianFullname;

  Treatment({
    required this.type,
    required this.hospitalName,
    required this.issuedDate,
    required this.physicianFullname,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) =>
      _$TreatmentFromJson(json);

  Map<String, dynamic> toJson() => _$TreatmentToJson(this);
}
