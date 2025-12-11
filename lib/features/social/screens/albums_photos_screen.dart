import 'package:flutter/material.dart';
import '../../../core/network/api/dio_jsonplaceholder_api.dart';

class AlbumsPhotosScreen extends StatefulWidget {
  const AlbumsPhotosScreen({super.key});

  @override
  State<AlbumsPhotosScreen> createState() => _AlbumsPhotosScreenState();
}

class _AlbumsPhotosScreenState extends State<AlbumsPhotosScreen> {
  late final DioJsonPlaceholderApi _api;
  List<Map<String, dynamic>> _albums = [];
  List<Map<String, dynamic>> _photos = [];
  bool _isLoading = false;
  bool _showingPhotos = false;
  int? _selectedAlbumId;
  String _lastAction = '';

  @override
  void initState() {
    super.initState();
    _api = DioJsonPlaceholderApi();
    _loadAlbums();
  }

  void _logAction(String action) {
    setState(() {
      _lastAction = action;
    });
  }

  Future<void> _loadAlbums() async {
    _logAction('GET /albums - Загрузка альбомов...');
    setState(() {
      _isLoading = true;
      _showingPhotos = false;
    });

    try {
      final albums = await _api.getAlbums();
      setState(() {
        _albums = albums;
        _isLoading = false;
      });
      _logAction('GET /albums - Загружено ${albums.length} альбомов ✓');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _logAction('GET /albums - Ошибка: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _loadPhotos(int albumId) async {
    _logAction('GET /photos?albumId=$albumId&_limit=20 - Загрузка фото...');
    setState(() {
      _isLoading = true;
      _showingPhotos = true;
      _selectedAlbumId = albumId;
    });

    try {
      final photos = await _api.getPhotos(albumId: albumId, limit: 20);
      setState(() {
        _photos = photos;
        _isLoading = false;
      });
      _logAction('GET /photos?albumId=$albumId - Загружено ${photos.length} фото ✓');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _logAction('GET /photos - Ошибка: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_showingPhotos ? 'Фотографии' : 'Альбомы'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        leading: _showingPhotos
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _loadAlbums,
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
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
                ? const Center(child: CircularProgressIndicator(color: Colors.purple))
                : _showingPhotos
                    ? GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _photos.length,
                        itemBuilder: (context, index) {
                          final photo = _photos[index];
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    photo['thumbnailUrl'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                          color: Colors.purple,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.purple.shade50,
                                  child: Text(
                                    photo['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _albums.length,
                        itemBuilder: (context, index) {
                          final album = _albums[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Text(
                                  '${album['userId']}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                album['title'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Album ID: ${album['id']} • User #${album['userId']}'),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('GET', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                              onTap: () => _loadPhotos(album['id']),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
