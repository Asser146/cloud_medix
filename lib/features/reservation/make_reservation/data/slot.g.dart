// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slot _$SlotFromJson(Map<String, dynamic> json) => Slot(
      json['reserved'] as bool,
      id: (json['id'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      physicianFullName: json['physicianFullName'] as String,
      specialtyName: json['specialtyName'] as String,
    );

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'physicianFullName': instance.physicianFullName,
      'specialtyName': instance.specialtyName,
      'reserved': instance.reserved,
    };
