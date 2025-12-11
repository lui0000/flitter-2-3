import '../data/users_rest_data_source.dart';
import '../data/models/user_dto.dart';

class UsersRestUseCase {
  final UsersRestDataSource _dataSource;

  UsersRestUseCase(this._dataSource);

  Future<List<UserDTO>> getAllUsers({int page = 1, int limit = 10}) async {
    if (page < 1) throw Exception('Page must be greater than 0');
    if (limit < 1 || limit > 100) throw Exception('Limit must be between 1 and 100');

    return await _dataSource.getAllUsers(page: page, limit: limit);
  }

  Future<UserDTO> getUserById(String id) async {
    if (id.trim().isEmpty) throw Exception('User ID cannot be empty');
    return await _dataSource.getUserById(id);
  }

  Future<UserDTO> createUser({
    required String name,
    required String email,
    required String role,
  }) async {
    if (name.trim().isEmpty) throw Exception('Name cannot be empty');
    if (email.trim().isEmpty || !email.contains('@')) {
      throw Exception('Invalid email');
    }
    if (role.trim().isEmpty) throw Exception('Role cannot be empty');

    return await _dataSource.createUser({
      'name': name,
      'email': email,
      'role': role,
    });
  }

  Future<UserDTO> updateUser(String id, {String? name, String? email, String? role}) async {
    if (id.trim().isEmpty) throw Exception('User ID cannot be empty');

    final data = <String, dynamic>{};
    if (name != null && name.isNotEmpty) data['name'] = name;
    if (email != null && email.isNotEmpty) data['email'] = email;
    if (role != null && role.isNotEmpty) data['role'] = role;

    if (data.isEmpty) throw Exception('No fields to update');

    return await _dataSource.partialUpdateUser(id, data);
  }

  Future<void> deleteUser(String id) async {
    if (id.trim().isEmpty) throw Exception('User ID cannot be empty');
    await _dataSource.deleteUser(id);
  }

  Future<List<UserDTO>> searchUsers({
    String? name,
    String? email,
    String? role,
    int page = 1,
    int limit = 10,
  }) async {
    return await _dataSource.searchUsers(
      name: name,
      email: email,
      role: role,
      page: page,
      limit: limit,
    );
  }
}

