import 'package:json_annotation/json_annotation.dart';
part 'specialty.g.dart';

@JsonSerializable()
class Specialty {
  int id;
  String name;

  Specialty({
    required this.id,
    required this.name,
  });
  Map<String, dynamic> toJson() => _$SpecialtyToJson(this);
  factory Specialty.fromJson(Map<String, dynamic> json) =>
      _$SpecialtyFromJson(json);
}
