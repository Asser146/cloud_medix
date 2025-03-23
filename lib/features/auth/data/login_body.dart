import 'package:json_annotation/json_annotation.dart';
part 'login_body.g.dart';

@JsonSerializable()
class LoginBody {
  final String userName;
  String? email;
  final String password;

  LoginBody({required this.userName, required this.password, this.email});

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
  factory LoginBody.fromJson(Map<String, dynamic> json) =>
      _$LoginBodyFromJson(json);
}
