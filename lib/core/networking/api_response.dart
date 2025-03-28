import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  @JsonKey(name: "statusCode")
  int? status;
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "data")
  T? data;
  ApiResponse({this.error, required this.data, this.status});
  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson(
          ApiResponse<T> apiResponse, Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}
