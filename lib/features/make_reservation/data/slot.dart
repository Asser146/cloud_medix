import 'package:json_annotation/json_annotation.dart';

part 'slot.g.dart';

@JsonSerializable()
class Slot {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String physicianFullName;
  final String specialtyName;
  final bool reserved;

  Slot(
    this.reserved, {
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.physicianFullName,
    required this.specialtyName,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);

  Map<String, dynamic> toJson() => _$SlotToJson(this);
}
