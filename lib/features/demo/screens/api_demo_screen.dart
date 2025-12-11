import 'package:flutter/material.dart';
import '../../social/screens/posts_screen.dart';
import '../../social/screens/albums_photos_screen.dart';
import '../../github/screens/github_screen.dart';

class ApiDemoScreen extends StatelessWidget {
  const ApiDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('API Демонстрация'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade700,
                      Colors.purple.shade600,
                    ],
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud, size: 60, color: Colors.white54),
                      SizedBox(height: 8),
                      Text(
                        '35+ сетевых запросов',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader('JSONPlaceholder API', Icons.public, Colors.orange),
                const SizedBox(height: 12),
                
                _buildApiCard(
                  context,
                  title: 'Посты',
                  description: 'GET /posts • POST /posts • DELETE /posts/{id}',
                  methods: ['GET', 'POST', 'PUT', 'DELETE'],
                  icon: Icons.article,
                  color: Colors.orange,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PostsScreen()),
                  ),
                ),
                
                _buildApiCard(
                  context,
                  title: 'Комментарии',
                  description: 'GET /comments • POST /comments',
                  methods: ['GET', 'POST'],
                  icon: Icons.comment,
                  color: Colors.deepOrange,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PostsScreen()),
                  ),
                ),
                
                _buildApiCard(
                  context,
                  title: 'Альбомы и Фото',
                  description: 'GET /albums • GET /photos с пагинацией',
                  methods: ['GET'],
                  icon: Icons.photo_library,
                  color: Colors.purple,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AlbumsPhotosScreen()),
                  ),
                ),
                
                _buildApiCard(
                  context,
                  title: 'Пользователи',
                  description: 'GET /users • GET /users/{id}/posts',
                  methods: ['GET'],
                  icon: Icons.people,
                  color: Colors.indigo,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PostsScreen()),
                  ),
                ),
                
                const SizedBox(height: 24),
                _buildSectionHeader('GitHub API', Icons.code, Colors.grey.shade800),
                const SizedBox(height: 12),
                
                _buildApiCard(
                  context,
                  title: 'Пользователи GitHub',
                  description: 'GET /users/{username}',
                  methods: ['GET'],
                  icon: Icons.person,
                  color: Colors.grey.shade800,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GithubScreen()),
                  ),
                ),
                
                _buildApiCard(
                  context,
                  title: 'Репозитории',
                  description: 'GET /users/{username}/repos • GET /repos/{owner}/{repo}',
                  methods: ['GET'],
                  icon: Icons.folder,
                  color: Colors.blueGrey,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GithubScreen()),
                  ),
                ),
                
                _buildApiCard(
                  context,
                  title: 'Issues и Commits',
                  description: 'GET /repos/../issues • GET /repos/../commits',
                  methods: ['GET'],
                  icon: Icons.bug_report,
                  color: Colors.teal,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GithubScreen()),
                  ),
                ),
                
                _buildApiCard(
                  context,
                  title: 'Поиск репозиториев',
                  description: 'GET /search/repositories',
                  methods: ['GET'],
                  icon: Icons.search,
                  color: Colors.cyan,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GithubScreen()),
                  ),
                ),
                
                const SizedBox(height: 24),
                _buildSectionHeader('Другие API (Retrofit)', Icons.api, Colors.green),
                const SizedBox(height: 12),
                
                _buildInfoCard(
                  'Products API',
                  'CRUD для продуктов • Фильтрация • Поиск',
                  ['GET', 'POST', 'PUT', 'DELETE'],
                  Icons.shopping_cart,
                  Colors.green,
                ),
                
                _buildInfoCard(
                  'Orders API',
                  'CRUD для заказов • Статусы • История',
                  ['GET', 'POST', 'PATCH', 'DELETE'],
                  Icons.receipt_long,
                  Colors.lightGreen,
                ),
                
                _buildInfoCard(
                  'Weather API (Dio)',
                  'Текущая погода • Прогноз на 5 дней',
                  ['GET'],
                  Icons.wb_sunny,
                  Colors.amber,
                ),
                
                const SizedBox(height: 24),
                _buildStatsCard(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildApiCard(
    BuildContext context, {
    required String title,
    required String description,
    required List<String> methods,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      children: methods.map((m) => _buildMethodChip(m)).toList(),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String description, List<String> methods, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    children: methods.map((m) => _buildMethodChip(m)).toList(),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Retrofit',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodChip(String method) {
    Color color;
    switch (method) {
      case 'GET':
        color = Colors.green;
        break;
      case 'POST':
        color = Colors.blue;
        break;
      case 'PUT':
        color = Colors.orange;
        break;
      case 'PATCH':
        color = Colors.purple;
        break;
      case 'DELETE':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        method,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade400,
            Colors.teal.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Итоговая статистика',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('5', 'API'),
              _buildStatItem('35+', 'Запросов'),
              _buildStatItem('5', 'HTTP методов'),
            ],
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              Text('✓ JSONPlaceholder', style: TextStyle(color: Colors.white70)),
              Text('✓ GitHub API', style: TextStyle(color: Colors.white70)),
              Text('✓ Products', style: TextStyle(color: Colors.white70)),
              Text('✓ Orders', style: TextStyle(color: Colors.white70)),
              Text('✓ Weather', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
