part of 'diagnosis_treatment_cubit.dart';

abstract class DiagnosisTreatmentState extends Equatable {
  const DiagnosisTreatmentState();

  @override
  List<Object?> get props => [];
}

final class DiagnosisTreatmentInitial extends DiagnosisTreatmentState {}

final class DiagnosisTreatmentLoading extends DiagnosisTreatmentState {}

final class DiagnosisTreatmentTabChanged extends DiagnosisTreatmentState {
  final int tabIndex;
  const DiagnosisTreatmentTabChanged({required this.tabIndex});
}

class DiagnosisLoaded extends DiagnosisTreatmentState {
  final List<Diagnosis> diagnosisList;

  const DiagnosisLoaded(this.diagnosisList);

  @override
  List<Object> get props => [diagnosisList];
}

class TreatmentLoaded extends DiagnosisTreatmentState {
  final List<Treatment> tratmentList;

  const TreatmentLoaded(this.tratmentList);

  @override
  List<Object> get props => [tratmentList];
}

class DiagnosisTreatmentError extends DiagnosisTreatmentState {
  final String message;

  const DiagnosisTreatmentError(this.message);

  @override
  List<Object> get props => [message];
}
