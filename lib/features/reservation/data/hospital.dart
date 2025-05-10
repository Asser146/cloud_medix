import 'package:json_annotation/json_annotation.dart';

part 'hospital.g.dart';

@JsonSerializable()
class Hospital {
  int id;
  String? routingUrl;
  String name;

  Hospital({
    required this.id,
    required this.name,
    this.routingUrl, // Optional and nullable
  });

  factory Hospital.fromJson(Map<String, dynamic> json) =>
      _$HospitalFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalToJson(this);
}
