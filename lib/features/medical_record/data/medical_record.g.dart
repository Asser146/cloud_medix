// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalRecord _$MedicalRecordFromJson(Map<String, dynamic> json) =>
    MedicalRecord(
      id: (json['id'] as num).toInt(),
      patientId: json['patientId'] as String,
      allergies: (json['allergies'] as List<dynamic>)
          .map((e) => Allergy.fromJson(e as Map<String, dynamic>))
          .toList(),
      chronics: (json['chronics'] as List<dynamic>)
          .map((e) => Chronic.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentMedications: (json['currentMedications'] as List<dynamic>)
          .map((e) => CurrentMedication.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'allergies': instance.allergies,
      'chronics': instance.chronics,
      'currentMedications': instance.currentMedications,
    };
