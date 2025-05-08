// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hospital _$HospitalFromJson(Map<String, dynamic> json) => Hospital(
      hospitalId: (json['hospitalId'] as num).toInt(),
      routingUrl: json['routingUrl'] as String,
      hospitalName: json['hospitalName'] as String,
    );

Map<String, dynamic> _$HospitalToJson(Hospital instance) => <String, dynamic>{
      'hospitalId': instance.hospitalId,
      'routingUrl': instance.routingUrl,
      'hospitalName': instance.hospitalName,
    };
