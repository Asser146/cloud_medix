// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Allergy _$AllergyFromJson(Map<String, dynamic> json) => Allergy(
      medicalRecordId: (json['medicalRecordId'] as num).toInt(),
      code: json['code'] as String,
      notes: json['notes'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AllergyToJson(Allergy instance) => <String, dynamic>{
      'medicalRecordId': instance.medicalRecordId,
      'code': instance.code,
      'notes': instance.notes,
      'description': instance.description,
    };
