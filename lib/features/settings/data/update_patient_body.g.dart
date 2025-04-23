// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_patient_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePatientBody _$UpdatePatientBodyFromJson(Map<String, dynamic> json) =>
    UpdatePatientBody(
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      emergencyContactName: json['emergencyContactName'] as String?,
      emergencyContactPhone: json['emergencyContactPhone'] as String?,
      emergencyContactRelation: json['emergencyContactRelation'] as String?,
    );

Map<String, dynamic> _$UpdatePatientBodyToJson(UpdatePatientBody instance) =>
    <String, dynamic>{
      'address': instance.address?.toJson(),
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactPhone': instance.emergencyContactPhone,
      'emergencyContactRelation': instance.emergencyContactRelation,
    };
