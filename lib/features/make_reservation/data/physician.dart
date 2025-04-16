import 'package:json_annotation/json_annotation.dart';
part 'physician.g.dart';

@JsonSerializable()
class Physician {
  int hospitalId;
  String id;
  String fullName;

  Physician({
    required this.hospitalId,
    required this.id,
    required this.fullName,
  });
  Map<String, dynamic> toJson() => _$PhysicianToJson(this);
  factory Physician.fromJson(Map<String, dynamic> json) =>
      _$PhysicianFromJson(json);
}
