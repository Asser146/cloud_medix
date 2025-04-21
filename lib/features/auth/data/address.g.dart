// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: (json['id'] as num?)?.toInt(),
      government: json['government'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      buildingNumber: (json['buildingNumber'] as num).toInt(),
      floor: (json['floor'] as num?)?.toInt(),
      apartmentNumber: (json['apartmentNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'government': instance.government,
      'city': instance.city,
      'street': instance.street,
      'buildingNumber': instance.buildingNumber,
      'floor': instance.floor,
      'apartmentNumber': instance.apartmentNumber,
    };
