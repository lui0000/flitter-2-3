import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsDataSource {
  final SharedPreferences _prefs;

  SharedPrefsDataSource(this._prefs);

  Future<bool> saveString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      return false;
    }
  }

  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      return false;
    }
  }

  int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      return false;
    }
  }

  bool? getBool(String key) {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e) {
      return false;
    }
  }

  double? getDouble(String key) {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveStringList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      return false;
    }
  }

  List<String>? getStringList(String key) {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      return false;
    }
  }

  bool containsKey(String key) {
    try {
      return _prefs.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  Set<String> getKeys() {
    try {
      return _prefs.getKeys();
    } catch (e) {
      return {};
    }
  }
}

