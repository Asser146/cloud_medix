import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_body.g.dart';

@JsonSerializable()
class RegisterBody {
  final String userName;
  final String email;
  final String password;
  final String fullName;
  final String nationalID;
  final String date;
  final String phone;
  Address? address;
  final int gender;

  RegisterBody(
      {required this.userName,
      required this.fullName,
      required this.nationalID,
      required this.date,
      required this.phone,
      this.address,
      required this.email,
      required this.password,
      required this.gender});

  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
  factory RegisterBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterBodyFromJson(json);
}
