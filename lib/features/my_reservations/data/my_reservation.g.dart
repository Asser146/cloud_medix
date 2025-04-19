// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyReservation _$MyReservationFromJson(Map<String, dynamic> json) =>
    MyReservation(
      id: (json['id'] as num).toInt(),
      reservationDate: DateTime.parse(json['reservationDate'] as String),
      status: (json['status'] as num).toInt(),
      slot: Slot.fromJson(json['slot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyReservationToJson(MyReservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reservationDate': instance.reservationDate.toIso8601String(),
      'status': instance.status,
      'slot': instance.slot,
    };
