import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/auth/data/login_response.dart';
import 'package:cloud_medix/features/auth/data/register_body.dart';
import 'package:cloud_medix/features/auth/domain/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthStateInitial());
  AuthRepository repo = getIt<AuthRepository>();
  late LoginResponse loginResponse;
  late ApiResponse registerResponse;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Future<void> login(String userName, String password) async {
    emit(const AuthLoading());
    loginResponse = await repo.loginPatient(userName, password);
    if (loginResponse.data.isNotEmpty) {
      await storage.write(key: "id", value: loginResponse.data[0]);
      await storage.write(key: "token", value: loginResponse.data[1]);
      await storage.write(key: "user_name", value: loginResponse.data[2]);
      emit(const AuthLoginDone());
    } else {
      emit(const AuthError("Login Failed"));
    }
  }

  Future<void> register(RegisterBody body) async {
    emit(const AuthLoading());
    registerResponse = await repo.registerPatient(body);
    if (registerResponse.status == 200) {
      if (registerResponse.data == null && registerResponse.error == null) {
        emit(const AuthregisterToLogin());
      } else {
        emit(AuthError(registerResponse.error.toString()));
      }
    } else {
      emit(AuthError("Server Error"));
    }
  }
}
