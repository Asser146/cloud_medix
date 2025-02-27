part of 'medical_record_cubit.dart';

sealed class MedicalRecordState extends Equatable {
  const MedicalRecordState();

  @override
  List<Object> get props => [];
}

final class MedicalRecordInitial extends MedicalRecordState {}

final class MedicalRecordLoading extends MedicalRecordState {}

final class MedicalRecordTabChanged extends MedicalRecordState {
  final int tabIndex;
  const MedicalRecordTabChanged({required this.tabIndex});
}
