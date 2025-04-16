import 'package:cloud_medix/features/settings/domain/repositories/settings_repository.dart';
import 'package:cloud_medix/features/settings/data/data_sources/settings_data_source.dart';



/// SettingsRepositoryImpl is the concrete implementation of the SettingsRepository
/// interface.
/// This class implements the methods defined in SettingsRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class SettingsRepositoryImpl implements SettingsRepository {
      
   final SettingsDataSource  settingsDataSource;
   SettingsRepositoryImpl(this.settingsDataSource);
}