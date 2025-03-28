// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Allergy _$AllergyFromJson(Map<String, dynamic> json) => Allergy(
      medicalRecordId: (json['medicalRecordId'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AllergyToJson(Allergy instance) => <String, dynamic>{
      'medicalRecordId': instance.medicalRecordId,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
    };
