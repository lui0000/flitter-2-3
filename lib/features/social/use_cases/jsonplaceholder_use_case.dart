import '../../../core/network/api/jsonplaceholder_api.dart';

class JsonPlaceholderUseCase {
  final JsonPlaceholderApi _api;

  JsonPlaceholderUseCase(this._api);

  Future<List<PostResponseDTO>> getAllPosts() async {
    try {
      return await _api.getPosts();
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<PostResponseDTO> getPostById(int id) async {
    try {
      return await _api.getPostById(id);
    } catch (e) {
      throw Exception('Failed to load post: $e');
    }
  }

  Future<PostResponseDTO> createPost({
    required int userId,
    required String title,
    required String body,
  }) async {
    try {
      final post = CreatePostDTO(userId: userId, title: title, body: body);
      return await _api.createPost(post);
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  Future<List<CommentDTO>> getCommentsByPost(int postId) async {
    try {
      return await _api.getComments(postId);
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  Future<CommentDTO> createComment({
    required int postId,
    required String name,
    required String email,
    required String body,
  }) async {
    try {
      final comment = CreateCommentDTO(
        postId: postId,
        name: name,
        email: email,
        body: body,
      );
      return await _api.createComment(comment);
    } catch (e) {
      throw Exception('Failed to create comment: $e');
    }
  }

  Future<List<PhotoDTO>> getPhotos({int? albumId, int? start, int? limit}) async {
    try {
      return await _api.getPhotos(albumId, start, limit);
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }

  Future<List<AlbumDTO>> getUserAlbums(int userId) async {
    try {
      return await _api.getAlbums(userId);
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }

  Future<UserResponseDTO> getUserById(int id) async {
    try {
      return await _api.getUserById(id);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<List<PostResponseDTO>> getUserPosts(int userId) async {
    try {
      return await _api.getUserPosts(userId);
    } catch (e) {
      throw Exception('Failed to load user posts: $e');
    }
  }
}

