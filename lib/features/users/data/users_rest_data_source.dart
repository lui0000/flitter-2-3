import '../../../core/network/rest_api_client.dart';
import 'models/user_dto.dart';

class UsersRestDataSource {
  final RestApiClient _apiClient;
  static const String _endpoint = '/users';

  UsersRestDataSource(this._apiClient);

  Future<List<UserDTO>> getAllUsers({int? page, int? limit}) async {
    final response = await _apiClient.getCollection(
      _endpoint,
      page: page,
      limit: limit,
    );
    
    final List<dynamic> data = response.data;
    return data.map((json) => UserDTO.fromJson(json)).toList();
  }

  Future<UserDTO> getUserById(String id) async {
    final response = await _apiClient.getResourceById(_endpoint, id);
    return UserDTO.fromJson(response.data);
  }

  Future<UserDTO> createUser(Map<String, dynamic> userData) async {
    final response = await _apiClient.createResource(_endpoint, userData);
    return UserDTO.fromJson(response.data);
  }

  Future<UserDTO> updateUser(String id, Map<String, dynamic> userData) async {
    final response = await _apiClient.updateResource(_endpoint, id, userData);
    return UserDTO.fromJson(response.data);
  }

  Future<UserDTO> partialUpdateUser(String id, Map<String, dynamic> fields) async {
    final response = await _apiClient.partialUpdateResource(_endpoint, id, fields);
    return UserDTO.fromJson(response.data);
  }

  Future<void> deleteUser(String id) async {
    await _apiClient.deleteResource(_endpoint, id);
  }

  Future<List<UserDTO>> searchUsers({
    String? name,
    String? email,
    String? role,
    int? page,
    int? limit,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (email != null) filters['email'] = email;
    if (role != null) filters['role'] = role;

    final response = await _apiClient.getCollection(
      _endpoint,
      page: page,
      limit: limit,
      filters: filters,
    );
    
    final List<dynamic> data = response.data;
    return data.map((json) => UserDTO.fromJson(json)).toList();
  }
}

