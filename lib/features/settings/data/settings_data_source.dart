import '../../../core/storage/shared_prefs_data_source.dart';

class SettingsDataSource {
  final SharedPrefsDataSource _storage;

  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLanguage = 'language';
  static const String _keyNotifications = 'notifications_enabled';

  SettingsDataSource(this._storage);

  Future<bool> saveThemeMode(String mode) async {
    return await _storage.saveString(_keyThemeMode, mode);
  }

  String getThemeMode() {
    return _storage.getString(_keyThemeMode) ?? 'system';
  }

  Future<bool> saveLanguage(String language) async {
    return await _storage.saveString(_keyLanguage, language);
  }

  String getLanguage() {
    return _storage.getString(_keyLanguage) ?? 'ru';
  }

  Future<bool> saveNotificationsEnabled(bool enabled) async {
    return await _storage.saveBool(_keyNotifications, enabled);
  }

  bool getNotificationsEnabled() {
    return _storage.getBool(_keyNotifications) ?? true;
  }

  Future<bool> clearSettings() async {
    bool result = true;
    result &= await _storage.remove(_keyThemeMode);
    result &= await _storage.remove(_keyLanguage);
    result &= await _storage.remove(_keyNotifications);
    return result;
  }
}

