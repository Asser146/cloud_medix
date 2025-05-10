// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyReservation _$MyReservationFromJson(Map<String, dynamic> json) =>
    MyReservation(
      id: (json['id'] as num).toInt(),
      patientId: json['patientId'] as String,
      physicianName: json['physicianName'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      reservationDate: DateTime.parse(json['reservationDate'] as String),
      status: (json['status'] as num).toInt(),
      hospital: Hospital.fromJson(json['hospital'] as Map<String, dynamic>),
      localSlotId: (json['localSlotId'] as num).toInt(),
    );

Map<String, dynamic> _$MyReservationToJson(MyReservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'physicianName': instance.physicianName,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'reservationDate': instance.reservationDate.toIso8601String(),
      'status': instance.status,
      'hospital': instance.hospital,
      'localSlotId': instance.localSlotId,
    };
