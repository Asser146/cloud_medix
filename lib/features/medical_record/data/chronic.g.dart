// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chronic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chronic _$ChronicFromJson(Map<String, dynamic> json) => Chronic(
      medicalRecordId: (json['medicalRecordId'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ChronicToJson(Chronic instance) => <String, dynamic>{
      'medicalRecordId': instance.medicalRecordId,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
    };
