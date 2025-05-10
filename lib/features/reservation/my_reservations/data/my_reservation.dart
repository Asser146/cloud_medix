import 'package:cloud_medix/features/reservation/data/hospital.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_reservation.g.dart';

@JsonSerializable()
class MyReservation {
  int id;
  String patientId;
  String physicianName;
  DateTime startTime;
  DateTime endTime;
  DateTime reservationDate;
  int status;
  Hospital hospital;
  int localSlotId;

  MyReservation({
    required this.id,
    required this.patientId,
    required this.physicianName,
    required this.startTime,
    required this.endTime,
    required this.reservationDate,
    required this.status,
    required this.hospital,
    required this.localSlotId,
  });

  factory MyReservation.fromJson(Map<String, dynamic> json) =>
      _$MyReservationFromJson(json);

  Map<String, dynamic> toJson() => _$MyReservationToJson(this);
}
