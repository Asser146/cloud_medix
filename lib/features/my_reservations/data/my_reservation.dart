import 'package:cloud_medix/features/make_reservation/data/slot.dart';
import 'package:json_annotation/json_annotation.dart';
part 'my_reservation.g.dart';

@JsonSerializable()
class MyReservation {
  int id;

  Slot slot;
  DateTime reservationDate;
  int status;

  MyReservation({
    required this.id,
    required this.slot,
    required this.reservationDate,
    required this.status,
  });

  Map<String, dynamic> toJson() => _$MyReservationToJson(this);
  factory MyReservation.fromJson(Map<String, dynamic> json) =>
      _$MyReservationFromJson(json);
}
