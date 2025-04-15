import 'package:cloud_medix/features/make_reservation/data/physician.dart';
import 'package:cloud_medix/features/make_reservation/data/specialty.dart';
import 'package:json_annotation/json_annotation.dart';
part 'slot.g.dart';

@JsonSerializable()
class Slot {
  int id;
  Specialty specialty;
  Physician physician;
  DateTime startTime;
  DateTime endTime;
  int availablePatients;
  int numberOfPatients;

  Slot({
    required this.id,
    required this.specialty,
    required this.physician,
    required this.startTime,
    required this.endTime,
    required this.availablePatients,
    required this.numberOfPatients,
  });

  Map<String, dynamic> toJson() => _$SlotToJson(this);
  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
}
