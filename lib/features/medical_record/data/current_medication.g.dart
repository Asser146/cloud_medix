// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_medication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentMedication _$CurrentMedicationFromJson(Map<String, dynamic> json) =>
    CurrentMedication(
      medicalRecordId: (json['medicalRecordId'] as num).toInt(),
      name: json['name'] as String,
      dose: (json['dose'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$CurrentMedicationToJson(CurrentMedication instance) =>
    <String, dynamic>{
      'medicalRecordId': instance.medicalRecordId,
      'name': instance.name,
      'dose': instance.dose,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
