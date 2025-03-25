// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalSlot _$HospitalSlotFromJson(Map<String, dynamic> json) => HospitalSlot(
      id: json['id'] as String,
      department: json['department'] as String,
      physician: json['physician'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$HospitalSlotToJson(HospitalSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'department': instance.department,
      'physician': instance.physician,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
