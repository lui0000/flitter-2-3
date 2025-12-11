import 'package:dio/dio.dart';
import 'dio_client_with_interceptors.dart';

class RestApiClient {
  final DioClientWithInterceptors _dioClient;

  RestApiClient(this._dioClient);

  Future<Response> getResource(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dioClient.get(path, queryParameters: queryParameters);
  }

  Future<Response> createResource(String path, Map<String, dynamic> data) async {
    return await _dioClient.post(path, data: data);
  }

  Future<Response> updateResource(String path, String id, Map<String, dynamic> data) async {
    return await _dioClient.put('$path/$id', data: data);
  }

  Future<Response> partialUpdateResource(String path, String id, Map<String, dynamic> data) async {
    return await _dioClient.dio.patch('$path/$id', data: data);
  }

  Future<Response> deleteResource(String path, String id) async {
    return await _dioClient.delete('$path/$id');
  }

  Future<Response> getResourceById(String path, String id) async {
    return await _dioClient.get('$path/$id');
  }

  Future<Response> getCollection(
    String path, {
    int? page,
    int? limit,
    String? sortBy,
    Map<String, dynamic>? filters,
  }) async {
    final queryParams = <String, dynamic>{};
    
    if (page != null) queryParams['page'] = page;
    if (limit != null) queryParams['limit'] = limit;
    if (sortBy != null) queryParams['sort'] = sortBy;
    if (filters != null) queryParams.addAll(filters);

    return await _dioClient.get(path, queryParameters: queryParams);
  }
}

