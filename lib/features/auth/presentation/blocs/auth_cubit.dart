import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/features/auth/domain/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthStateInitial());
  AuthRepository repo = getIt<AuthRepository>();

  Future<bool> login() async {
    emit(const AuthLoading());
    if (await repo.loginPatient()) {
      emit(const AuthLoaded());
      return true;
    } else {
      emit(const AuthLoaded());
      return false;
    }
  }
}
