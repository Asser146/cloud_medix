// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physician.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Physician _$PhysicianFromJson(Map<String, dynamic> json) => Physician(
      hospitalId: (json['hospitalId'] as num).toInt(),
      id: json['id'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$PhysicianToJson(Physician instance) => <String, dynamic>{
      'hospitalId': instance.hospitalId,
      'id': instance.id,
      'fullName': instance.fullName,
    };
