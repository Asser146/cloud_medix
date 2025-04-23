import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_medix/features/auth/data/address.dart';

part 'update_patient_body.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdatePatientBody {
  final Address? address;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? emergencyContactRelation;

  UpdatePatientBody({
    this.address,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelation,
  });

  factory UpdatePatientBody.fromJson(Map<String, dynamic> json) =>
      _$UpdatePatientBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePatientBodyToJson(this);
}
