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

final class AuthLoginDone extends AuthState {
  const AuthLoginDone();
}

final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object> get props => [message];
}

final class AuthregisterToLogin extends AuthState {
  const AuthregisterToLogin();
  @override
  List<Object> get props => [];
}
