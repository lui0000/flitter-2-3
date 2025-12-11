import 'package:dio/dio.dart';

class DioGithubApi {
  final Dio _dio;

  DioGithubApi()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://api.github.com',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Accept': 'application/vnd.github.v3+json',
          },
        ));

  Future<Map<String, dynamic>> getUserByUsername(String username) async {
    final response = await _dio.get('/users/$username');
    return Map<String, dynamic>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getUserRepositories(
    String username, {
    String? sort,
    int? perPage,
  }) async {
    final response = await _dio.get('/users/$username/repos', queryParameters: {
      if (sort != null) 'sort': sort,
      if (perPage != null) 'per_page': perPage,
    });
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> getRepository(String owner, String repo) async {
    final response = await _dio.get('/repos/$owner/$repo');
    return Map<String, dynamic>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getRepositoryIssues(
    String owner,
    String repo, {
    String? state,
    int? perPage,
  }) async {
    final response = await _dio.get('/repos/$owner/$repo/issues', queryParameters: {
      if (state != null) 'state': state,
      if (perPage != null) 'per_page': perPage,
    });
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getRepositoryCommits(
    String owner,
    String repo, {
    int? perPage,
  }) async {
    final response = await _dio.get('/repos/$owner/$repo/commits', queryParameters: {
      if (perPage != null) 'per_page': perPage,
    });
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> searchRepositories(
    String query, {
    String? sort,
    int? perPage,
  }) async {
    final response = await _dio.get('/search/repositories', queryParameters: {
      'q': query,
      if (sort != null) 'sort': sort,
      if (perPage != null) 'per_page': perPage,
    });
    return Map<String, dynamic>.from(response.data);
  }
}

