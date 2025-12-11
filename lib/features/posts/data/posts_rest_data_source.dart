import '../../../core/network/rest_api_client.dart';
import 'models/post_dto.dart';

class PostsRestDataSource {
  final RestApiClient _apiClient;
  static const String _endpoint = '/posts';

  PostsRestDataSource(this._apiClient);

  Future<PaginatedResponse<PostDTO>> getPosts({
    int page = 1,
    int limit = 10,
    String? sortBy,
  }) async {
    final response = await _apiClient.getCollection(
      _endpoint,
      page: page,
      limit: limit,
      sortBy: sortBy,
    );

    return PaginatedResponse.fromJson(
      response.data,
      (json) => PostDTO.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<PostDTO> getPostById(String id) async {
    final response = await _apiClient.getResourceById(_endpoint, id);
    return PostDTO.fromJson(response.data);
  }

  Future<PostDTO> createPost({
    required String title,
    required String body,
    required String userId,
  }) async {
    final response = await _apiClient.createResource(_endpoint, {
      'title': title,
      'body': body,
      'userId': userId,
    });
    return PostDTO.fromJson(response.data);
  }

  Future<PostDTO> updatePost(String id, {String? title, String? body}) async {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (body != null) data['body'] = body;

    final response = await _apiClient.partialUpdateResource(_endpoint, id, data);
    return PostDTO.fromJson(response.data);
  }

  Future<void> deletePost(String id) async {
    await _apiClient.deleteResource(_endpoint, id);
  }

  Future<List<PostDTO>> getPostsByUser(String userId) async {
    final response = await _apiClient.getCollection(
      _endpoint,
      filters: {'userId': userId},
    );

    final List<dynamic> data = response.data;
    return data.map((json) => PostDTO.fromJson(json)).toList();
  }
}

class PaginatedResponse<T> {
  final List<T> data;
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  PaginatedResponse({
    required this.data,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return PaginatedResponse(
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}

