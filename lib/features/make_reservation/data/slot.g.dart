// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slot _$SlotFromJson(Map<String, dynamic> json) => Slot(
      id: (json['id'] as num).toInt(),
      specialty: Specialty.fromJson(json['specialty'] as Map<String, dynamic>),
      physician: Physician.fromJson(json['physician'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      availablePatients: (json['availablePatients'] as num).toInt(),
      numberOfPatients: (json['numberOfPatients'] as num).toInt(),
    );

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'id': instance.id,
      'specialty': instance.specialty,
      'physician': instance.physician,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'availablePatients': instance.availablePatients,
      'numberOfPatients': instance.numberOfPatients,
    };
