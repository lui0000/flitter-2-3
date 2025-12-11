import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jsonplaceholder_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class JsonPlaceholderApi {
  factory JsonPlaceholderApi(Dio dio, {String baseUrl}) = _JsonPlaceholderApi;

  @GET("/posts")
  Future<List<PostResponseDTO>> getPosts();

  @GET("/posts/{id}")
  Future<PostResponseDTO> getPostById(@Path("id") int id);

  @POST("/posts")
  Future<PostResponseDTO> createPost(@Body() CreatePostDTO post);

  @PUT("/posts/{id}")
  Future<PostResponseDTO> updatePost(
    @Path("id") int id,
    @Body() CreatePostDTO post,
  );

  @DELETE("/posts/{id}")
  Future<void> deletePost(@Path("id") int id);

  @GET("/comments")
  Future<List<CommentDTO>> getComments(@Query("postId") int? postId);

  @GET("/comments/{id}")
  Future<CommentDTO> getCommentById(@Path("id") int id);

  @POST("/comments")
  Future<CommentDTO> createComment(@Body() CreateCommentDTO comment);

  @GET("/albums")
  Future<List<AlbumDTO>> getAlbums(@Query("userId") int? userId);

  @GET("/albums/{id}")
  Future<AlbumDTO> getAlbumById(@Path("id") int id);

  @GET("/photos")
  Future<List<PhotoDTO>> getPhotos(
    @Query("albumId") int? albumId,
    @Query("_start") int? start,
    @Query("_limit") int? limit,
  );

  @GET("/photos/{id}")
  Future<PhotoDTO> getPhotoById(@Path("id") int id);

  @GET("/users")
  Future<List<UserResponseDTO>> getUsers();

  @GET("/users/{id}")
  Future<UserResponseDTO> getUserById(@Path("id") int id);

  @GET("/users/{id}/posts")
  Future<List<PostResponseDTO>> getUserPosts(@Path("id") int userId);
}

@JsonSerializable()
class PostResponseDTO {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostResponseDTO({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PostResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$PostResponseDTOToJson(this);
}

@JsonSerializable()
class CreatePostDTO {
  final int userId;
  final String title;
  final String body;

  CreatePostDTO({
    required this.userId,
    required this.title,
    required this.body,
  });

  factory CreatePostDTO.fromJson(Map<String, dynamic> json) =>
      _$CreatePostDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePostDTOToJson(this);
}

@JsonSerializable()
class CommentDTO {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentDTO({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentDTO.fromJson(Map<String, dynamic> json) =>
      _$CommentDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CommentDTOToJson(this);
}

@JsonSerializable()
class CreateCommentDTO {
  final int postId;
  final String name;
  final String email;
  final String body;

  CreateCommentDTO({
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CreateCommentDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCommentDTOToJson(this);
}

@JsonSerializable()
class AlbumDTO {
  final int userId;
  final int id;
  final String title;

  AlbumDTO({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumDTO.fromJson(Map<String, dynamic> json) =>
      _$AlbumDTOFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumDTOToJson(this);
}

@JsonSerializable()
class PhotoDTO {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoDTO({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoDTO.fromJson(Map<String, dynamic> json) =>
      _$PhotoDTOFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoDTOToJson(this);
}

@JsonSerializable()
class UserResponseDTO {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressDTO? address;
  final String? phone;
  final String? website;
  final CompanyDTO? company;

  UserResponseDTO({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseDTOToJson(this);
}

@JsonSerializable()
class AddressDTO {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoDTO? geo;

  AddressDTO({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory AddressDTO.fromJson(Map<String, dynamic> json) =>
      _$AddressDTOFromJson(json);
  Map<String, dynamic> toJson() => _$AddressDTOToJson(this);
}

@JsonSerializable()
class GeoDTO {
  final String? lat;
  final String? lng;

  GeoDTO({this.lat, this.lng});

  factory GeoDTO.fromJson(Map<String, dynamic> json) =>
      _$GeoDTOFromJson(json);
  Map<String, dynamic> toJson() => _$GeoDTOToJson(this);
}

@JsonSerializable()
class CompanyDTO {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  CompanyDTO({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory CompanyDTO.fromJson(Map<String, dynamic> json) =>
      _$CompanyDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyDTOToJson(this);
}
