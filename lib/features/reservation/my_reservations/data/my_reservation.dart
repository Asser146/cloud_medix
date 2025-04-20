import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_reservation.g.dart';

@JsonSerializable()
class MyReservation {
  final int id;
  final DateTime reservationDate;
  final int status;
  final Slot slot;

  MyReservation({
    required this.id,
    required this.reservationDate,
    required this.status,
    required this.slot,
  });

  factory MyReservation.fromJson(Map<String, dynamic> json) =>
      _$MyReservationFromJson(json);

  Map<String, dynamic> toJson() => _$MyReservationToJson(this);
}
