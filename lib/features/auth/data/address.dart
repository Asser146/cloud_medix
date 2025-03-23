import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  final String government;
  final String city;
  final String street;
  final int buildingNumber;
  int? floor;
  int? apartmentNumber;

  Address(
      {required this.government,
      required this.city,
      required this.street,
      required this.buildingNumber});

  Map<String, dynamic> toJson() => _$AddressToJson(this);
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
