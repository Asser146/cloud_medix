// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemUser _$SystemUserFromJson(Map<String, dynamic> json) => SystemUser(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      nationalID: json['nationalID'] as String,
      date: json['date'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$SystemUserToJson(SystemUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'nationalID': instance.nationalID,
      'date': instance.date,
      'phone': instance.phone,
    };
