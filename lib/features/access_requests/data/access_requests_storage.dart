import 'dart:convert';
import '../../../core/storage/shared_prefs_data_source.dart';

class AccessRequestsStorage {
  final SharedPrefsDataSource _storage;

  static const String _keyRequests = 'access_requests';
  static const String _keyLastDeleted = 'last_deleted_request';
  static const String _keyLastDeletedIndex = 'last_deleted_index';

  AccessRequestsStorage(this._storage);

  Future<bool> saveRequests(List<Map<String, dynamic>> requests) async {
    try {
      final jsonString = json.encode(requests);
      return await _storage.saveString(_keyRequests, jsonString);
    } catch (e) {
      return false;
    }
  }

  List<Map<String, dynamic>> getRequests() {
    try {
      final jsonString = _storage.getString(_keyRequests);
      if (jsonString != null) {
        final List<dynamic> decoded = json.decode(jsonString);
        return decoded.map((e) => e as Map<String, dynamic>).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> addRequest(Map<String, dynamic> request) async {
    try {
      final requests = getRequests();
      requests.add(request);
      return await saveRequests(requests);
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateRequest(String id, Map<String, dynamic> updatedRequest) async {
    try {
      final requests = getRequests();
      final index = requests.indexWhere((r) => r['id'] == id);
      if (index != -1) {
        requests[index] = updatedRequest;
        return await saveRequests(requests);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteRequest(String id) async {
    try {
      final requests = getRequests();
      final index = requests.indexWhere((r) => r['id'] == id);
      if (index != -1) {
        final deleted = requests.removeAt(index);
        await _storage.saveString(_keyLastDeleted, json.encode(deleted));
        await _storage.saveInt(_keyLastDeletedIndex, index);
        return await saveRequests(requests);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> undoDelete() async {
    try {
      final lastDeletedJson = _storage.getString(_keyLastDeleted);
      final lastDeletedIndex = _storage.getInt(_keyLastDeletedIndex);

      if (lastDeletedJson != null && lastDeletedIndex != null) {
        final deleted = json.decode(lastDeletedJson) as Map<String, dynamic>;
        final requests = getRequests();
        requests.insert(lastDeletedIndex, deleted);
        await _storage.remove(_keyLastDeleted);
        await _storage.remove(_keyLastDeletedIndex);
        return await saveRequests(requests);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearAll() async {
    bool result = true;
    result &= await _storage.remove(_keyRequests);
    result &= await _storage.remove(_keyLastDeleted);
    result &= await _storage.remove(_keyLastDeletedIndex);
    return result;
  }

  Map<String, dynamic>? getRequestById(String id) {
    try {
      final requests = getRequests();
      return requests.firstWhere((r) => r['id'] == id);
    } catch (e) {
      return null;
    }
  }
}

