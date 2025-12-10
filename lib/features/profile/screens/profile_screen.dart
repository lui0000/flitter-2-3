import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/state/auth_state.dart';

/// Экран профиля пользователя
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthState>().currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 16),
            Text(user?.name ?? 'Гость', style: Theme.of(context).textTheme.headlineSmall),
            Text(user?.email ?? '', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Chip(label: Text('Роль: ${user?.role ?? 'Не определена'}')),
            const SizedBox(height: 32),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(user?.email ?? '-'),
            ),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('Роль'),
              subtitle: Text(user?.role ?? '-'),
            ),
          ],
        ),
      ),
    );
  }
}


