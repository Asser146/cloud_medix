import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String fullName;
  final String nationalID;
  final DateTime date;
  final String phone;
  Address? address;

  User({
    required this.fullName,
    required this.nationalID,
    required this.date,
    required this.phone,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
