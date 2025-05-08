import 'package:json_annotation/json_annotation.dart';

part 'hospital.g.dart';

@JsonSerializable()
class Hospital {
  int hospitalId;
  String routingUrl;
  String hospitalName;

  Hospital({
    required this.hospitalId,
    required this.routingUrl,
    required this.hospitalName,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) =>
      _$HospitalFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalToJson(this);
}
