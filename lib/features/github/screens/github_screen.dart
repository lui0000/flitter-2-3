import 'package:flutter/material.dart';
import '../../../core/network/api/dio_github_api.dart';

class GithubScreen extends StatefulWidget {
  const GithubScreen({super.key});

  @override
  State<GithubScreen> createState() => _GithubScreenState();
}

class _GithubScreenState extends State<GithubScreen> {
  late final DioGithubApi _api;
  final _searchController = TextEditingController(text: 'torvalds');
  
  Map<String, dynamic>? _currentUser;
  List<Map<String, dynamic>> _repositories = [];
  bool _isLoading = false;
  String? _error;
  String _lastAction = '';

  @override
  void initState() {
    super.initState();
    _api = DioGithubApi();
    _searchUser('torvalds');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _logAction(String action) {
    setState(() {
      _lastAction = action;
    });
  }

  Future<void> _searchUser(String username) async {
    if (username.trim().isEmpty) return;

    _logAction('GET /users/$username - Поиск пользователя...');
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final user = await _api.getUserByUsername(username);
      _logAction('GET /users/$username - Пользователь найден ✓');
      
      _logAction('GET /users/$username/repos - Загрузка репозиториев...');
      final repos = await _api.getUserRepositories(username, sort: 'updated', perPage: 10);
      
      setState(() {
        _currentUser = user;
        _repositories = repos;
        _isLoading = false;
      });
      _logAction('GET /users/$username/repos - Загружено ${repos.length} репозиториев ✓');
    } catch (e) {
      setState(() {
        _error = 'Пользователь не найден';
        _isLoading = false;
      });
      _logAction('Ошибка: $e');
    }
  }

  Future<void> _viewIssues(String owner, String repo) async {
    _logAction('GET /repos/$owner/$repo/issues - Загрузка issues...');
    
    try {
      final issues = await _api.getRepositoryIssues(owner, repo, state: 'all', perPage: 15);
      
      _logAction('GET /repos/$owner/$repo/issues - Загружено ${issues.length} issues ✓');
      
      if (mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.bug_report, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Issues: $repo (${issues.length})',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('GET', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: issues.isEmpty
                      ? const Center(child: Text('Нет issues'))
                      : ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: issues.length,
                          itemBuilder: (context, index) {
                            final issue = issues[index];
                            final state = issue['state'] ?? 'open';
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: Icon(
                                  state == 'open' ? Icons.error_outline : Icons.check_circle,
                                  color: state == 'open' ? Colors.green : Colors.purple,
                                ),
                                title: Text(issue['title'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                                subtitle: Text('#${issue['number']} • $state'),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      _logAction('Ошибка: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _viewCommits(String owner, String repo) async {
    _logAction('GET /repos/$owner/$repo/commits - Загрузка коммитов...');
    
    try {
      final commits = await _api.getRepositoryCommits(owner, repo, perPage: 15);
      
      _logAction('GET /repos/$owner/$repo/commits - Загружено ${commits.length} коммитов ✓');
      
      if (mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.commit, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Commits: $repo (${commits.length})',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('GET', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: commits.length,
                    itemBuilder: (context, index) {
                      final commit = commits[index];
                      final sha = commit['sha'] ?? '';
                      final commitData = commit['commit'] as Map<String, dynamic>?;
                      final message = commitData?['message'] ?? 'No message';
                      final author = commitData?['author'] as Map<String, dynamic>?;
                      final authorName = author?['name'] ?? 'Unknown';
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: Text(
                              sha.substring(0, 2).toUpperCase(),
                              style: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                            ),
                          ),
                          title: Text(
                            message.split('\n').first,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(authorName),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              sha.length >= 7 ? sha.substring(0, 7) : sha,
                              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      _logAction('Ошибка: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub API'),
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade900,
            child: Row(
              children: [
                const Icon(Icons.terminal, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _lastAction.isEmpty ? 'Готов к выполнению запросов...' : _lastAction,
                    style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'GitHub Username',
                      hintText: 'torvalds, microsoft, flutter...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    onSubmitted: _searchUser,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _searchUser(_searchController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade900,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('GET'),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_off, size: 64, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text(_error!, style: TextStyle(color: Colors.grey.shade600)),
                            const SizedBox(height: 8),
                            const Text('Попробуйте: torvalds, microsoft, flutter'),
                          ],
                        ),
                      )
                    : _currentUser == null
                        ? const Center(child: Text('Введите username для поиска'))
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Colors.grey.shade800, Colors.grey.shade900],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(_currentUser!['avatar_url'] ?? ''),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        _currentUser!['name'] ?? _currentUser!['login'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '@${_currentUser!['login']}',
                                        style: TextStyle(color: Colors.grey.shade400),
                                      ),
                                      if (_currentUser!['bio'] != null) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          _currentUser!['bio'],
                                          style: TextStyle(color: Colors.grey.shade300),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildStat('Repos', _currentUser!['public_repos'] ?? 0),
                                          _buildStat('Followers', _currentUser!['followers'] ?? 0),
                                          _buildStat('Following', _currentUser!['following'] ?? 0),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.folder, color: Colors.grey),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Репозитории (${_repositories.length})',
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  itemCount: _repositories.length,
                                  itemBuilder: (context, index) {
                                    final repo = _repositories[index];
                                    final language = repo['language'];
                                    final description = repo['description'];
                                    
                                    return Card(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.grey.shade200,
                                              child: const Icon(Icons.folder, color: Colors.grey),
                                            ),
                                            title: Text(
                                              repo['name'] ?? '',
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (description != null && description.toString().isNotEmpty)
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 4),
                                                    child: Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
                                                  ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Icon(Icons.star, size: 16, color: Colors.amber.shade700),
                                                    Text(' ${repo['stargazers_count'] ?? 0}'),
                                                    const SizedBox(width: 16),
                                                    const Icon(Icons.call_split, size: 16),
                                                    Text(' ${repo['forks_count'] ?? 0}'),
                                                    const SizedBox(width: 16),
                                                    if (language != null) ...[
                                                      Container(
                                                        width: 10,
                                                        height: 10,
                                                        decoration: BoxDecoration(
                                                          color: _getLanguageColor(language),
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(language),
                                                    ],
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(height: 1),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextButton.icon(
                                                  onPressed: () => _viewIssues(_currentUser!['login'], repo['name']),
                                                  icon: const Icon(Icons.bug_report, size: 18),
                                                  label: const Text('Issues'),
                                                ),
                                              ),
                                              Container(width: 1, height: 24, color: Colors.grey.shade300),
                                              Expanded(
                                                child: TextButton.icon(
                                                  onPressed: () => _viewCommits(_currentUser!['login'], repo['name']),
                                                  icon: const Icon(Icons.commit, size: 18),
                                                  label: const Text('Commits'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'c':
        return Colors.grey;
      case 'c++':
        return Colors.pink;
      case 'python':
        return Colors.blue;
      case 'javascript':
        return Colors.yellow.shade700;
      case 'dart':
        return Colors.teal;
      case 'java':
        return Colors.orange;
      case 'kotlin':
        return Colors.purple;
      case 'swift':
        return Colors.orange.shade700;
      case 'go':
        return Colors.cyan;
      case 'rust':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStat(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
