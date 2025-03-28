import 'package:json_annotation/json_annotation.dart';
part 'chronic.g.dart';

@JsonSerializable()
class Chronic {
  int medicalRecordId;
  String name;
  String type;
  String description;

  Chronic({
    required this.medicalRecordId,
    required this.name,
    required this.type,
    required this.description,
  });
  Map<String, dynamic> toJson() => _$ChronicToJson(this);
  factory Chronic.fromJson(Map<String, dynamic> json) =>
      _$ChronicFromJson(json);
}
