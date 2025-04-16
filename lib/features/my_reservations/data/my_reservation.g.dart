// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyReservation _$MyReservationFromJson(Map<String, dynamic> json) =>
    MyReservation(
      id: (json['id'] as num).toInt(),
      slot: Slot.fromJson(json['slot'] as Map<String, dynamic>),
      reservationDate: DateTime.parse(json['reservationDate'] as String),
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$MyReservationToJson(MyReservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot': instance.slot,
      'reservationDate': instance.reservationDate.toIso8601String(),
      'status': instance.status,
    };
