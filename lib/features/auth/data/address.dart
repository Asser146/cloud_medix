import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  int? id;
  String government;
  String city;
  String street;
  int buildingNumber;
  int? floor;
  int? apartmentNumber;

  Address({
    this.id,
    required this.government,
    required this.city,
    required this.street,
    required this.buildingNumber,
    this.floor,
    this.apartmentNumber,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
