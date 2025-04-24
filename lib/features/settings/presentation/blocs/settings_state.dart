part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final User user;

  const SettingsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object> get props => [message];
}

class SettingsUpdated extends SettingsState {
  final User user;

  const SettingsUpdated(this.user);

  @override
  List<Object?> get props => [user];
}
