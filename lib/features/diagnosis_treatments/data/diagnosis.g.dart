// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) => Diagnosis(
      code: json['code'] as String,
      description: json['description'] as String,
      hospitalName: json['hospitalName'] as String,
      issuedDate: json['issuedDate'] as String,
      physicianFullname: json['physicianFullname'] as String,
    );

Map<String, dynamic> _$DiagnosisToJson(Diagnosis instance) => <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'hospitalName': instance.hospitalName,
      'issuedDate': instance.issuedDate,
      'physicianFullname': instance.physicianFullname,
    };
