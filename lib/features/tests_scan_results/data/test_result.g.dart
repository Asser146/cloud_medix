// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResult _$TestResultFromJson(Map<String, dynamic> json) => TestResult(
      dateOfResult: DateTime.parse(json['dateOfResult'] as String),
      department: (json['department'] as num).toInt(),
      tests: (json['tests'] as List<dynamic>).map((e) => e as String).toList(),
      results:
          (json['results'] as List<dynamic>).map((e) => e as String).toList(),
      notes: json['notes'] as String?,
      physicianFullName: json['physicianFullName'] as String,
    );

Map<String, dynamic> _$TestResultToJson(TestResult instance) =>
    <String, dynamic>{
      'dateOfResult': instance.dateOfResult.toIso8601String(),
      'department': instance.department,
      'tests': instance.tests,
      'results': instance.results,
      'notes': instance.notes,
      'physicianFullName': instance.physicianFullName,
    };
