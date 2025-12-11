import '../../../core/database/sql_database_helper.dart';

class AccessRequestsSqlStorage {
  final SqlDatabaseHelper _dbHelper;

  AccessRequestsSqlStorage(this._dbHelper);

  Future<void> insertRequest(Map<String, dynamic> request) async {
    await _dbHelper.insert('access_requests', request);
  }

  Future<List<Map<String, dynamic>>> getAllRequests() async {
    return await _dbHelper.query('access_requests');
  }

  Future<Map<String, dynamic>?> getRequestById(String id) async {
    final results = await _dbHelper.query('access_requests', where: 'id = ?', whereArgs: [id]);
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getPendingRequests() async {
    return await _dbHelper.query('access_requests', where: 'is_approved = ?', whereArgs: [0]);
  }

  Future<List<Map<String, dynamic>>> getApprovedRequests() async {
    return await _dbHelper.query('access_requests', where: 'is_approved = ?', whereArgs: [1]);
  }

  Future<void> updateRequest(String id, Map<String, dynamic> request) async {
    await _dbHelper.update('access_requests', request, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> approveRequest(String id) async {
    await _dbHelper.update('access_requests', {'is_approved': 1}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteRequest(String id) async {
    await _dbHelper.delete('access_requests', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getRequestsByEmployee(String employee) async {
    return await _dbHelper.query('access_requests', where: 'employee = ?', whereArgs: [employee]);
  }

  Future<List<Map<String, dynamic>>> getRequestsByAccessType(String accessType) async {
    return await _dbHelper.query('access_requests', where: 'access_type = ?', whereArgs: [accessType]);
  }

  Future<int> getRequestCount() async {
    final result = await _dbHelper.rawQuery('SELECT COUNT(*) as count FROM access_requests');
    return result.first['count'] as int;
  }
}

