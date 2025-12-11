import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_api.g.dart';

@RestApi(baseUrl: "https://api.github.com")
abstract class GithubApi {
  factory GithubApi(Dio dio, {String baseUrl}) = _GithubApi;

  @GET("/users/{username}")
  Future<GithubUserDTO> getUserByUsername(@Path("username") String username);

  @GET("/users/{username}/repos")
  Future<List<RepositoryDTO>> getUserRepositories(
    @Path("username") String username,
    @Query("sort") String? sort,
    @Query("per_page") int? perPage,
  );

  @GET("/repos/{owner}/{repo}")
  Future<RepositoryDTO> getRepository(
    @Path("owner") String owner,
    @Path("repo") String repo,
  );

  @GET("/repos/{owner}/{repo}/issues")
  Future<List<IssueDTO>> getRepositoryIssues(
    @Path("owner") String owner,
    @Path("repo") String repo,
    @Query("state") String? state,
    @Query("per_page") int? perPage,
  );

  @GET("/repos/{owner}/{repo}/commits")
  Future<List<CommitDTO>> getRepositoryCommits(
    @Path("owner") String owner,
    @Path("repo") String repo,
    @Query("per_page") int? perPage,
  );

  @GET("/search/repositories")
  Future<SearchRepositoriesResponse> searchRepositories(
    @Query("q") String query,
    @Query("sort") String? sort,
    @Query("per_page") int? perPage,
  );
}

@JsonSerializable()
class GithubUserDTO {
  final String login;
  final int id;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  final String? name;
  final String? bio;
  @JsonKey(name: 'public_repos')
  final int publicRepos;
  final int followers;
  final int following;
  @JsonKey(name: 'created_at')
  final String createdAt;

  GithubUserDTO({
    required this.login,
    required this.id,
    required this.avatarUrl,
    this.name,
    this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.createdAt,
  });

  factory GithubUserDTO.fromJson(Map<String, dynamic> json) =>
      _$GithubUserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$GithubUserDTOToJson(this);
}

@JsonSerializable()
class RepositoryDTO {
  final int id;
  final String name;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String? description;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String? language;
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;
  @JsonKey(name: 'forks_count')
  final int forksCount;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  RepositoryDTO({
    required this.id,
    required this.name,
    required this.fullName,
    this.description,
    required this.htmlUrl,
    this.language,
    required this.stargazersCount,
    required this.forksCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RepositoryDTO.fromJson(Map<String, dynamic> json) =>
      _$RepositoryDTOFromJson(json);
  Map<String, dynamic> toJson() => _$RepositoryDTOToJson(this);
}

@JsonSerializable()
class IssueDTO {
  final int id;
  final int number;
  final String title;
  final String state;
  final String? body;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  IssueDTO({
    required this.id,
    required this.number,
    required this.title,
    required this.state,
    this.body,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IssueDTO.fromJson(Map<String, dynamic> json) =>
      _$IssueDTOFromJson(json);
  Map<String, dynamic> toJson() => _$IssueDTOToJson(this);
}

@JsonSerializable()
class CommitDTO {
  final String sha;
  final CommitDetailsDTO commit;

  CommitDTO({
    required this.sha,
    required this.commit,
  });

  factory CommitDTO.fromJson(Map<String, dynamic> json) =>
      _$CommitDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CommitDTOToJson(this);
}

@JsonSerializable()
class CommitDetailsDTO {
  final String message;
  final CommitAuthorDTO? author;

  CommitDetailsDTO({
    required this.message,
    this.author,
  });

  factory CommitDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$CommitDetailsDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CommitDetailsDTOToJson(this);
}

@JsonSerializable()
class CommitAuthorDTO {
  final String? name;
  final String? email;
  final String? date;

  CommitAuthorDTO({
    this.name,
    this.email,
    this.date,
  });

  factory CommitAuthorDTO.fromJson(Map<String, dynamic> json) =>
      _$CommitAuthorDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CommitAuthorDTOToJson(this);
}

@JsonSerializable()
class SearchRepositoriesResponse {
  @JsonKey(name: 'total_count')
  final int totalCount;
  final List<RepositoryDTO> items;

  SearchRepositoriesResponse({
    required this.totalCount,
    required this.items,
  });

  factory SearchRepositoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRepositoriesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRepositoriesResponseToJson(this);
}
