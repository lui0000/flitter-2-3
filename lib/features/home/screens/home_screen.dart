import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_router.dart';
import '../../auth/state/auth_state.dart';

/// Главный экран с навигацией
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthState>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('IDM Система'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthState>().logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Приветствие
            Text(
              'Добро пожаловать, ${user?.name ?? 'Гость'}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _MenuCard(
                    icon: Icons.assignment,
                    title: 'Заявки',
                    subtitle: 'Управление заявками на доступ',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.accessRequests),
                  ),
                  _MenuCard(
                    icon: Icons.people,
                    title: 'Пользователи',
                    subtitle: 'Управление пользователями',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.users),
                  ),
                  _MenuCard(
                    icon: Icons.admin_panel_settings,
                    title: 'Роли',
                    subtitle: 'Настройка ролей',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.roles),
                  ),
                  _MenuCard(
                    icon: Icons.storage,
                    title: 'Ресурсы',
                    subtitle: 'Системы и ресурсы',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.resources),
                  ),
                  _MenuCard(
                    icon: Icons.history,
                    title: 'Аудит',
                    subtitle: 'История действий',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.audit),
                  ),
                  _MenuCard(
                    icon: Icons.person,
                    title: 'Профиль',
                    subtitle: 'Личный кабинет',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                  ),
                  _MenuCard(
                    icon: Icons.settings,
                    title: 'Настройки',
                    subtitle: 'Параметры системы',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                  ),
                  _MenuCard(
                    icon: Icons.api,
                    title: 'API Демо',
                    subtitle: '35+ сетевых запросов',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.apiDemo),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Карточка меню
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 8),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

