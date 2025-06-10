// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chronic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chronic _$ChronicFromJson(Map<String, dynamic> json) => Chronic(
      medicalRecordId: (json['medicalRecordId'] as num).toInt(),
      code: json['code'] as String,
      notes: json['notes'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ChronicToJson(Chronic instance) => <String, dynamic>{
      'medicalRecordId': instance.medicalRecordId,
      'code': instance.code,
      'notes': instance.notes,
      'description': instance.description,
    };
