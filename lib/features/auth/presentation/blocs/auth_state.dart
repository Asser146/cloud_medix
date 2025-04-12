part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthLoaded extends AuthState {
  const AuthLoaded();
}

final class AuthError extends AuthState {
  const AuthError();
}
