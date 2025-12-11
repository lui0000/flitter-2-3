import 'package:dio/dio.dart';

class DioJsonPlaceholderApi {
  final Dio _dio;

  DioJsonPlaceholderApi()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  Future<List<Map<String, dynamic>>> getPosts() async {
    final response = await _dio.get('/posts');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> getPostById(int id) async {
    final response = await _dio.get('/posts/$id');
    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> createPost({
    required int userId,
    required String title,
    required String body,
  }) async {
    final response = await _dio.post('/posts', data: {
      'userId': userId,
      'title': title,
      'body': body,
    });
    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> updatePost(int id, {
    required int userId,
    required String title,
    required String body,
  }) async {
    final response = await _dio.put('/posts/$id', data: {
      'userId': userId,
      'title': title,
      'body': body,
    });
    return Map<String, dynamic>.from(response.data);
  }

  Future<void> deletePost(int id) async {
    await _dio.delete('/posts/$id');
  }

  Future<List<Map<String, dynamic>>> getComments({int? postId}) async {
    final response = await _dio.get('/comments', queryParameters: {
      if (postId != null) 'postId': postId,
    });
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getAlbums({int? userId}) async {
    final response = await _dio.get('/albums', queryParameters: {
      if (userId != null) 'userId': userId,
    });
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getPhotos({int? albumId, int? start, int? limit}) async {
    final response = await _dio.get('/photos', queryParameters: {
      if (albumId != null) 'albumId': albumId,
      if (start != null) '_start': start,
      if (limit != null) '_limit': limit,
    });
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await _dio.get('/users');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> getUserById(int id) async {
    final response = await _dio.get('/users/$id');
    return Map<String, dynamic>.from(response.data);
  }
}

