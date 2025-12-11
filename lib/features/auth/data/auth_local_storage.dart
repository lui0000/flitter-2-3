import 'dart:convert';
import '../../../core/storage/shared_prefs_data_source.dart';

class AuthLocalStorage {
  final SharedPrefsDataSource _storage;

  static const String _keyCurrentUser = 'current_user';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyRememberMe = 'remember_me';

  AuthLocalStorage(this._storage);

  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    try {
      final jsonString = json.encode(userData);
      await _storage.saveBool(_keyIsLoggedIn, true);
      return await _storage.saveString(_keyCurrentUser, jsonString);
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic>? getUserData() {
    try {
      final jsonString = _storage.getString(_keyCurrentUser);
      if (jsonString != null) {
        return json.decode(jsonString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  bool isLoggedIn() {
    return _storage.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<bool> setRememberMe(bool value) async {
    return await _storage.saveBool(_keyRememberMe, value);
  }

  bool getRememberMe() {
    return _storage.getBool(_keyRememberMe) ?? false;
  }

  Future<bool> logout() async {
    await _storage.remove(_keyCurrentUser);
    return await _storage.saveBool(_keyIsLoggedIn, false);
  }

  Future<bool> clearAll() async {
    bool result = true;
    result &= await _storage.remove(_keyCurrentUser);
    result &= await _storage.remove(_keyIsLoggedIn);
    result &= await _storage.remove(_keyRememberMe);
    return result;
  }
}

