import '../../../core/storage/shared_prefs_data_source.dart';
import '../data/settings_data_source.dart';

class ThemeUseCase {
  final SettingsDataSource _settingsDataSource;

  ThemeUseCase(SharedPrefsDataSource storage)
      : _settingsDataSource = SettingsDataSource(storage);

  Future<bool> setThemeMode(String mode) async {
    try {
      return await _settingsDataSource.saveThemeMode(mode);
    } catch (e) {
      return false;
    }
  }

  String getThemeMode() {
    try {
      return _settingsDataSource.getThemeMode();
    } catch (e) {
      return 'system';
    }
  }

  Future<bool> setLanguage(String language) async {
    try {
      return await _settingsDataSource.saveLanguage(language);
    } catch (e) {
      return false;
    }
  }

  String getLanguage() {
    try {
      return _settingsDataSource.getLanguage();
    } catch (e) {
      return 'ru';
    }
  }

  Future<bool> setNotificationsEnabled(bool enabled) async {
    try {
      return await _settingsDataSource.saveNotificationsEnabled(enabled);
    } catch (e) {
      return false;
    }
  }

  bool getNotificationsEnabled() {
    try {
      return _settingsDataSource.getNotificationsEnabled();
    } catch (e) {
      return true;
    }
  }
}

