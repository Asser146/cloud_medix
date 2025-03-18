import 'package:json_annotation/json_annotation.dart';

part 'system_user.g.dart';

@JsonSerializable()
class SystemUser {
  final String id;
  final String fullName;
  final String nationalID;
  final String date;
  final String phone;

  SystemUser({
    required this.id,
    required this.fullName,
    required this.nationalID,
    required this.date,
    required this.phone,
  });

  factory SystemUser.fromJson(Map<String, dynamic> json) =>
      _$SystemUserFromJson(json);

  Map<String, dynamic> toJson() => _$SystemUserToJson(this);
}
