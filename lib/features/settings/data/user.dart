import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String fullName;
  final String nationalID;
  final DateTime date;
  final String phone;
  Address address;
  String? emergencyContactName;
  String? emergencyContactPhone;
  String? emergencyContactRelation;
  String? userName;

  User({
    required this.fullName,
    required this.nationalID,
    required this.date,
    required this.phone,
    required this.address,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelation,
    this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
