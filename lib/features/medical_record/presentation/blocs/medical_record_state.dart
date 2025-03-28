part of 'medical_record_cubit.dart';

abstract class MedicalRecordState extends Equatable {
  const MedicalRecordState();

  @override
  List<Object?> get props => [];
}

final class MedicalRecordInitial extends MedicalRecordState {}

final class MedicalRecordLoading extends MedicalRecordState {}

final class MedicalRecordTabChanged extends MedicalRecordState {
  final int tabIndex;
  const MedicalRecordTabChanged({required this.tabIndex});
}

class MedicalRecordLoaded extends MedicalRecordState {
  final MedicalRecord medicalRecord;

  const MedicalRecordLoaded(this.medicalRecord);

  @override
  List<Object> get props => [medicalRecord];
}

class MedicalRecordError extends MedicalRecordState {
  final String message;

  const MedicalRecordError(this.message);

  @override
  List<Object> get props => [message];
}
