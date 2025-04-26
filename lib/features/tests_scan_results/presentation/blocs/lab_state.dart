part of 'lab_cubit.dart';

abstract class LabState extends Equatable {
  const LabState();

  @override
  List<Object?> get props => [];
}

final class LabInitial extends LabState {}

final class LabLoading extends LabState {}

final class LabTabChanged extends LabState {
  final int tabIndex;
  const LabTabChanged({required this.tabIndex});
}

class LabLoaded extends LabState {
  final List<TestRequest> tests;

  const LabLoaded(this.tests);

  @override
  List<Object> get props => [tests];
}

final class LabResultLoading extends LabState {
  final List<TestRequest> tests;
  const LabResultLoading(this.tests);
  @override
  List<Object> get props => [tests];
}

class LabResultLoaded extends LabState {
  final TestResult result;
  final List<TestRequest> tests;

  const LabResultLoaded(this.result, this.tests);

  @override
  List<Object> get props => [result, tests];
}

class LabError extends LabState {
  final String message;

  const LabError(this.message);

  @override
  List<Object> get props => [message];
}
