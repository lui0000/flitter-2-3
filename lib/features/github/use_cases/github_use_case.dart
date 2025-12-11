import '../../../core/network/api/github_api.dart';

class GithubUseCase {
  final GithubApi _api;

  GithubUseCase(this._api);

  Future<GithubUserDTO> getUserByUsername(String username) async {
    try {
      if (username.trim().isEmpty) {
        throw Exception('Username cannot be empty');
      }
      return await _api.getUserByUsername(username);
    } catch (e) {
      throw Exception('Failed to load GitHub user: $e');
    }
  }

  Future<List<RepositoryDTO>> getUserRepositories(
    String username, {
    String sort = 'updated',
    int perPage = 30,
  }) async {
    try {
      if (username.trim().isEmpty) {
        throw Exception('Username cannot be empty');
      }
      return await _api.getUserRepositories(username, sort, perPage);
    } catch (e) {
      throw Exception('Failed to load repositories: $e');
    }
  }

  Future<RepositoryDTO> getRepository(String owner, String repo) async {
    try {
      if (owner.trim().isEmpty || repo.trim().isEmpty) {
        throw Exception('Owner and repository name cannot be empty');
      }
      return await _api.getRepository(owner, repo);
    } catch (e) {
      throw Exception('Failed to load repository: $e');
    }
  }

  Future<List<IssueDTO>> getRepositoryIssues(
    String owner,
    String repo, {
    String state = 'open',
    int perPage = 30,
  }) async {
    try {
      return await _api.getRepositoryIssues(owner, repo, state, perPage);
    } catch (e) {
      throw Exception('Failed to load issues: $e');
    }
  }

  Future<List<CommitDTO>> getRepositoryCommits(
    String owner,
    String repo, {
    int perPage = 30,
  }) async {
    try {
      return await _api.getRepositoryCommits(owner, repo, perPage);
    } catch (e) {
      throw Exception('Failed to load commits: $e');
    }
  }

  Future<SearchRepositoriesResponse> searchRepositories(
    String query, {
    String sort = 'stars',
    int perPage = 30,
  }) async {
    try {
      if (query.trim().isEmpty) {
        throw Exception('Search query cannot be empty');
      }
      return await _api.searchRepositories(query, sort, perPage);
    } catch (e) {
      throw Exception('Failed to search repositories: $e');
    }
  }
}

