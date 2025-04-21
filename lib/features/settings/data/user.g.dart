// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      fullName: json['fullName'] as String,
      nationalID: json['nationalID'] as String,
      date: DateTime.parse(json['date'] as String),
      phone: json['phone'] as String,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'nationalID': instance.nationalID,
      'date': instance.date.toIso8601String(),
      'phone': instance.phone,
      'address': instance.address,
    };
