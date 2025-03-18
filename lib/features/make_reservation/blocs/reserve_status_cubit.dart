import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reserve_status_state.dart';

class ReserveStatusCubit extends Cubit<ReserveStatusState> {
  ReserveStatusCubit() : super(const ReserveStatusInitial());
  AuthRepository repo = getIt<AuthRepository>();
  bool selected = false;

  void toggleSlot() {
    emit(const ReserveStatusInitial());
    selected = !selected;
    repo.registerPatient();
    emit(ReserveStatusToggled(selected));
  }
}
