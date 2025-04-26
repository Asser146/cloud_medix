import 'package:json_annotation/json_annotation.dart';
part 'test_request.g.dart';

@JsonSerializable()
class TestRequest {
  DateTime dateOfRequest;
  List<String> tests;
  int department;
  int status;
  String physicianFullName;

  TestRequest({
    required this.dateOfRequest,
    required this.tests,
    required this.department,
    required this.status,
    required this.physicianFullName,
  });

  Map<String, dynamic> toJson() => _$TestRequestToJson(this);
  factory TestRequest.fromJson(Map<String, dynamic> json) =>
      _$TestRequestFromJson(json);
}
