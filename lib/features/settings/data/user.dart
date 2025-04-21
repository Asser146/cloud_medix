import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String fullName;
  final String nationalId;
  final DateTime date;
  final String phone;
  final Address address;

  User({
    required this.fullName,
    required this.nationalId,
    required this.date,
    required this.phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
