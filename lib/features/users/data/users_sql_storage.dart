import '../../../core/database/sql_database_helper.dart';

class UsersSqlStorage {
  final SqlDatabaseHelper _dbHelper;

  UsersSqlStorage(this._dbHelper);

  Future<void> insertUser(Map<String, dynamic> user) async {
    await _dbHelper.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    return await _dbHelper.query('users');
  }

  Future<Map<String, dynamic>?> getUserById(String id) async {
    final results = await _dbHelper.query('users', where: 'id = ?', whereArgs: [id]);
    return results.isNotEmpty ? results.first : null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final results = await _dbHelper.query('users', where: 'email = ?', whereArgs: [email]);
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getUsersByRole(String role) async {
    return await _dbHelper.query('users', where: 'role = ?', whereArgs: [role]);
  }

  Future<void> updateUser(String id, Map<String, dynamic> user) async {
    await _dbHelper.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteUser(String id) async {
    await _dbHelper.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getUserCount() async {
    final result = await _dbHelper.rawQuery('SELECT COUNT(*) as count FROM users');
    return result.first['count'] as int;
  }

  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    return await _dbHelper.rawQuery(
      'SELECT * FROM users WHERE name LIKE ? OR email LIKE ?',
      ['%$query%', '%$query%'],
    );
  }
}

