// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationBody _$ReservationBodyFromJson(Map<String, dynamic> json) =>
    ReservationBody(
      hospitalPatientInternalId:
          (json['hospitalPatientInternalId'] as num).toInt(),
      slotId: (json['slotId'] as num).toInt(),
      reservationDate: DateTime.parse(json['reservationDate'] as String),
    );

Map<String, dynamic> _$ReservationBodyToJson(ReservationBody instance) =>
    <String, dynamic>{
      'hospitalPatientInternalId': instance.hospitalPatientInternalId,
      'slotId': instance.slotId,
      'reservationDate': instance.reservationDate.toIso8601String(),
    };
