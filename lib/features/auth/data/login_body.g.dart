// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) => LoginBody(
      userName: json['userName'] as String,
      password: json['password'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
    };
