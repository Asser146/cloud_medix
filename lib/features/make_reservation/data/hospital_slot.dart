import 'package:json_annotation/json_annotation.dart';
part 'hospital_slot.g.dart';

@JsonSerializable()
class HospitalSlot {
  final String id;
  final String department;
  final String physician;
  final String startTime;
  final String endTime;
  HospitalSlot(
      {required this.id,
      required this.department,
      required this.physician,
      required this.startTime,
      required this.endTime});

  Map<String, dynamic> toJson() => _$HospitalSlotToJson(this);
  factory HospitalSlot.fromJson(Map<String, dynamic> json) =>
      _$HospitalSlotFromJson(json);
}
