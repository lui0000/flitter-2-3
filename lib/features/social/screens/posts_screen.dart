import 'package:flutter/material.dart';
import '../../../core/network/api/dio_jsonplaceholder_api.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late final DioJsonPlaceholderApi _api;
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;
  String? _error;
  String _lastAction = '';

  @override
  void initState() {
    super.initState();
    _api = DioJsonPlaceholderApi();
    _loadPosts();
  }

  void _logAction(String action) {
    setState(() {
      _lastAction = action;
    });
  }

  Future<void> _loadPosts() async {
    _logAction('GET /posts - Загрузка всех постов...');
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final posts = await _api.getPosts();
      setState(() {
        _posts = posts.take(20).toList();
        _isLoading = false;
      });
      _logAction('GET /posts - Загружено ${posts.length} постов ✓');
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      _logAction('GET /posts - Ошибка: $e');
    }
  }

  Future<void> _createPost() async {
    _logAction('POST /posts - Создание нового поста...');
    
    try {
      final created = await _api.createPost(
        userId: 1,
        title: 'Новый пост #${DateTime.now().millisecondsSinceEpoch % 1000}',
        body: 'Это тестовый пост, созданный через API',
      );
      
      _logAction('POST /posts - Пост создан с ID: ${created['id']} ✓');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('POST /posts → Создан пост ID: ${created['id']}'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      _logAction('POST /posts - Ошибка: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _deletePost(int id) async {
    _logAction('DELETE /posts/$id - Удаление поста...');
    
    try {
      await _api.deletePost(id);
      
      _logAction('DELETE /posts/$id - Пост удален ✓');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('DELETE /posts/$id → Пост удален'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _posts.removeWhere((p) => p['id'] == id);
        });
      }
    } catch (e) {
      _logAction('DELETE /posts/$id - Ошибка: $e');
    }
  }

  Future<void> _viewComments(int postId) async {
    _logAction('GET /comments?postId=$postId - Загрузка комментариев...');
    
    try {
      final comments = await _api.getComments(postId: postId);
      
      _logAction('GET /comments?postId=$postId - Загружено ${comments.length} комментариев ✓');
      
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
                    color: Colors.orange.shade50,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.comment, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'Комментарии (${comments.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
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
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.orange.shade100,
                                    child: Text(
                                      (comment['name'] as String)[0].toUpperCase(),
                                      style: TextStyle(color: Colors.orange.shade700),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment['name'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          comment['email'],
                                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(comment['body']),
                            ],
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
      _logAction('GET /comments?postId=$postId - Ошибка: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaceholder API'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPosts,
          ),
        ],
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
          
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.orange))
                : _error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error, size: 64, color: Colors.red),
                            const SizedBox(height: 16),
                            Text('Ошибка: $_error'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadPosts,
                              child: const Text('Повторить'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _posts.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          final post = _posts[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.orange,
                                        child: Text(
                                          '${post['userId']}',
                                          style: const TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'User #${post['userId']}',
                                        style: TextStyle(color: Colors.grey.shade600),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'Post #${post['id']}',
                                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post['title'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        post['body'],
                                        style: TextStyle(color: Colors.grey.shade700),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(height: 1),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton.icon(
                                        onPressed: () => _viewComments(post['id']),
                                        icon: const Icon(Icons.comment, size: 18),
                                        label: const Text('Комментарии'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.orange,
                                        ),
                                      ),
                                    ),
                                    Container(width: 1, height: 24, color: Colors.grey.shade300),
                                    Expanded(
                                      child: TextButton.icon(
                                        onPressed: () => _deletePost(post['id']),
                                        icon: const Icon(Icons.delete, size: 18),
                                        label: const Text('Удалить'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createPost,
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add),
        label: const Text('POST'),
      ),
    );
  }
}
