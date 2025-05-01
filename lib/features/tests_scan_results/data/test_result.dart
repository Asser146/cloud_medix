import 'package:json_annotation/json_annotation.dart';
part 'test_result.g.dart';

@JsonSerializable()
class TestResult {
  DateTime dateOfResult;
  int department;
  List<String> tests;
  List<String> results;
  String? notes;
  String physicianFullName;

  TestResult({
    required this.dateOfResult,
    required this.department,
    required this.tests,
    required this.results,
    required this.notes,
    required this.physicianFullName,
  });

  Map<String, dynamic> toJson() => _$TestResultToJson(this);
  factory TestResult.fromJson(Map<String, dynamic> json) =>
      _$TestResultFromJson(json);
}
