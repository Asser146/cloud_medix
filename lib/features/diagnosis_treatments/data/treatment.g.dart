// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Treatment _$TreatmentFromJson(Map<String, dynamic> json) => Treatment(
      type: json['type'] as String,
      hospitalName: json['hospitalName'] as String,
      issuedDate: DateTime.parse(json['issuedDate'] as String),
      physicianFullname: json['physicianFullname'] as String,
    );

Map<String, dynamic> _$TreatmentToJson(Treatment instance) => <String, dynamic>{
      'type': instance.type,
      'hospitalName': instance.hospitalName,
      'issuedDate': instance.issuedDate.toIso8601String(),
      'physicianFullname': instance.physicianFullname,
    };
