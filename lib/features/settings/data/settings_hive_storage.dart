import '../../../core/database/hive_storage_helper.dart';

class SettingsHiveStorage {
  final HiveStorageHelper _hive;
  static const String _boxName = 'settings';

  SettingsHiveStorage(this._hive);

  Future<void> saveTheme(String theme) async {
    await _hive.put(_boxName, 'theme', theme);
  }

  Future<String> getTheme() async {
    return await _hive.get<String>(_boxName, 'theme') ?? 'system';
  }

  Future<void> saveLanguage(String language) async {
    await _hive.put(_boxName, 'language', language);
  }

  Future<String> getLanguage() async {
    return await _hive.get<String>(_boxName, 'language') ?? 'ru';
  }

  Future<void> saveNotifications(bool enabled) async {
    await _hive.put(_boxName, 'notifications', enabled);
  }

  Future<bool> getNotifications() async {
    return await _hive.get<bool>(_boxName, 'notifications') ?? true;
  }

  Future<void> saveFontSize(double size) async {
    await _hive.put(_boxName, 'font_size', size);
  }

  Future<double> getFontSize() async {
    return await _hive.get<double>(_boxName, 'font_size') ?? 14.0;
  }

  Future<void> saveAllSettings(Map<String, dynamic> settings) async {
    await _hive.putAll(_boxName, settings);
  }

  Future<Map<String, dynamic>> getAllSettings() async {
    return await _hive.getAll(_boxName);
  }

  Future<void> clearSettings() async {
    await _hive.clear(_boxName);
  }
}

