import '../../../core/database/hive_storage_helper.dart';

class AuditHiveStorage {
  final HiveStorageHelper _hive;
  static const String _boxName = 'audit_logs';

  AuditHiveStorage(this._hive);

  Future<void> logAction(Map<String, dynamic> log) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    await _hive.put(_boxName, timestamp, log);
  }

  Future<Map<String, dynamic>> getAllLogs() async {
    return await _hive.getAll(_boxName);
  }

  Future<List<Map<String, dynamic>>> getLogsList() async {
    final logsMap = await getAllLogs();
    return logsMap.entries.map((e) => {
      'timestamp': e.key,
      ...Map<String, dynamic>.from(e.value),
    }).toList();
  }

  Future<void> deleteLog(String timestamp) async {
    await _hive.delete(_boxName, timestamp);
  }

  Future<void> clearAllLogs() async {
    await _hive.clear(_boxName);
  }

  Future<List<Map<String, dynamic>>> getLogsByUser(String userId) async {
    final logs = await getLogsList();
    return logs.where((log) => log['user_id'] == userId).toList();
  }

  Future<List<Map<String, dynamic>>> getLogsByAction(String action) async {
    final logs = await getLogsList();
    return logs.where((log) => log['action'] == action).toList();
  }

  Future<int> getLogsCount() async {
    final keys = await _hive.getKeys(_boxName);
    return keys.length;
  }
}

