// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hospital _$HospitalFromJson(Map<String, dynamic> json) => Hospital(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      routingUrl: json['routingUrl'] as String?,
    );

Map<String, dynamic> _$HospitalToJson(Hospital instance) => <String, dynamic>{
      'id': instance.id,
      'routingUrl': instance.routingUrl,
      'name': instance.name,
    };
