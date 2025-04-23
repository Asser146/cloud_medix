import 'package:bloc/bloc.dart';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/settings/data/user.dart';
import 'package:cloud_medix/features/settings/domain/settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial()) {
    getSettings();
  }

  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  final SettingsRepository repo = getIt<SettingsRepository>();
  late User user;

  List<Map<String, String>> emergencyContacts = [];

  int selectedtabIndex = 0;

  Future<void> getSettings() async {
    emit(SettingsLoading());
    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const SettingsError("User ID is missing Error"));
      return;
    } else {
      ApiResponse response = await repo.getMySettings(id);
      if (response.status == 200 && response.data != null) {
        user = response.data;
        emit(SettingsLoaded(user));
      } else {
        emit(SettingsError(response.error ?? "No Settings available."));
      }
    }
  }
}
