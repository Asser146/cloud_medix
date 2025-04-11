import 'dart:developer';

import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/features/auth/data/login_response.dart';
import 'package:cloud_medix/features/auth/domain/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthStateInitial());
  AuthRepository repo = getIt<AuthRepository>();
  late LoginResponse responseData;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  // Future<bool> CheckLogin() async {
  //   emit(const AuthLoading());
  //   responseData = await repo.loginPatient();
  //   await storage.write(key: "id", value: responseData[0]);
  //   await storage.write(key: "token", value: responseData[1]);
  //   if (responseData.isNotEmpty) {
  //     emit(const AuthLoaded());
  //     return true;
  //   } else {
  //     emit(const AuthLoaded());
  //     return false;
  //   }
  // }
  Future<bool> login() async {
    emit(const AuthLoading());
    responseData = await repo.loginPatient();
    if (responseData.data.isNotEmpty) {
      // await storage.write(key: "id", value: "2");
      // await storage.write(key: "token", value: responseData.data[1]);
      emit(const AuthLoaded());
      return true;
    } else {
      emit(const AuthLoaded());
      // return false;
      return true;
    }
  }
}
          // if (context.read<RegisterCubit>().formKey.currentState!.validate()) {
          //   Navigator.of(context).pushNamed(Routes.welcome);
          // } else {}


// Create storage

// Read value
// String value = await storage.read(key: key);

// // Read all values
// Map<String, String> allValues = await storage.readAll();

// // Delete value
// await storage.delete(key: key);

// // Delete all
// await storage.deleteAll();

// // Write value
// await storage.write(key: key, value: value);