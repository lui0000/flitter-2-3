import '../data/auth_secure_storage.dart';

class AuthUseCase {
  final AuthSecureStorage _secureStorage;

  AuthUseCase(this._secureStorage);

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final accessToken = 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}';
      final refreshToken = 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}';
      final userId = 'user_${email.hashCode}';

      await _secureStorage.saveAuthData(
        accessToken: accessToken,
        refreshToken: refreshToken,
        userId: userId,
        email: email,
      );

      if (password.isNotEmpty) {
        await _secureStorage.savePassword(password);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await _secureStorage.clearAuthData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      return await _secureStorage.isAuthenticated();
    } catch (e) {
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.getAccessToken();
    } catch (e) {
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.getRefreshToken();
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, String?>> getUserData() async {
    try {
      return await _secureStorage.getAuthData();
    } catch (e) {
      return {};
    }
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken == null) {
        return false;
      }

      final newAccessToken = 'mock_new_access_token_${DateTime.now().millisecondsSinceEpoch}';
      await _secureStorage.saveAccessToken(newAccessToken);
      
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePassword(String newPassword) async {
    try {
      await _secureStorage.savePassword(newPassword);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getSavedPassword() async {
    try {
      return await _secureStorage.getPassword();
    } catch (e) {
      return null;
    }
  }
}

