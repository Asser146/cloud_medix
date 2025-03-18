// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBody _$RegisterBodyFromJson(Map<String, dynamic> json) => RegisterBody(
      userName: json['userName'] as String,
      fullName: json['fullName'] as String,
      nationalID: json['nationalID'] as String,
      date: json['date'] as String,
      phone: json['phone'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterBodyToJson(RegisterBody instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'fullName': instance.fullName,
      'nationalID': instance.nationalID,
      'date': instance.date,
      'phone': instance.phone,
      'address': instance.address,
    };
