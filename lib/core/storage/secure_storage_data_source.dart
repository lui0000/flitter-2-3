import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageDataSource {
  final FlutterSecureStorage _storage;

  SecureStorageDataSource(this._storage);

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw Exception('Failed to write secure data: $e');
    }
  }

  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw Exception('Failed to delete secure data: $e');
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Failed to clear secure storage: $e');
    }
  }

  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      return {};
    }
  }

  Future<void> writeMultiple(Map<String, String> data) async {
    try {
      for (var entry in data.entries) {
        await _storage.write(key: entry.key, value: entry.value);
      }
    } catch (e) {
      throw Exception('Failed to write multiple secure data: $e');
    }
  }

  Future<void> deleteMultiple(List<String> keys) async {
    try {
      for (var key in keys) {
        await _storage.delete(key: key);
      }
    } catch (e) {
      throw Exception('Failed to delete multiple secure data: $e');
    }
  }
}

