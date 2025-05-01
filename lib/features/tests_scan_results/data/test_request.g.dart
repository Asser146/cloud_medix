// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestRequest _$TestRequestFromJson(Map<String, dynamic> json) => TestRequest(
      id: json['id'] as String,
      dateOfRequest: DateTime.parse(json['dateOfRequest'] as String),
      tests: (json['tests'] as List<dynamic>).map((e) => e as String).toList(),
      department: (json['department'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      physicianFullName: json['physicianFullName'] as String,
    );

Map<String, dynamic> _$TestRequestToJson(TestRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateOfRequest': instance.dateOfRequest.toIso8601String(),
      'tests': instance.tests,
      'department': instance.department,
      'status': instance.status,
      'physicianFullName': instance.physicianFullName,
    };
