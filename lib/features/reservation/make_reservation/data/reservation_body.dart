import 'package:json_annotation/json_annotation.dart';

part 'reservation_body.g.dart';

@JsonSerializable()
class ReservationBody {
  final int hospitalPatientInternalId;
  final int slotId;
  final DateTime reservationDate;

  ReservationBody({
    required this.hospitalPatientInternalId,
    required this.slotId,
    required this.reservationDate,
  });

  factory ReservationBody.fromJson(Map<String, dynamic> json) =>
      _$ReservationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationBodyToJson(this);
}
