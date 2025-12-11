import '../../../core/storage/secure_storage_data_source.dart';

class AuthSecureStorage {
  final SecureStorageDataSource _storage;

  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyPassword = 'user_password';

  AuthSecureStorage(this._storage);

  Future<void> saveAccessToken(String token) async {
    await _storage.write(_keyAccessToken, token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(_keyAccessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(_keyRefreshToken, token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(_keyRefreshToken);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(_keyUserId, userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(_keyUserId);
  }

  Future<void> saveUserEmail(String email) async {
    await _storage.write(_keyUserEmail, email);
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(_keyUserEmail);
  }

  Future<void> savePassword(String password) async {
    await _storage.write(_keyPassword, password);
  }

  Future<String?> getPassword() async {
    return await _storage.read(_keyPassword);
  }

  Future<void> saveAuthData({
    required String accessToken,
    String? refreshToken,
    required String userId,
    required String email,
  }) async {
    await _storage.writeMultiple({
      _keyAccessToken: accessToken,
      if (refreshToken != null) _keyRefreshToken: refreshToken,
      _keyUserId: userId,
      _keyUserEmail: email,
    });
  }

  Future<Map<String, String?>> getAuthData() async {
    return {
      'accessToken': await getAccessToken(),
      'refreshToken': await getRefreshToken(),
      'userId': await getUserId(),
      'email': await getUserEmail(),
    };
  }

  Future<bool> hasAccessToken() async {
    return await _storage.containsKey(_keyAccessToken);
  }

  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearAuthData() async {
    await _storage.deleteMultiple([
      _keyAccessToken,
      _keyRefreshToken,
      _keyUserId,
      _keyUserEmail,
      _keyPassword,
    ]);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

