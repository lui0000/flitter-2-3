import 'package:flutter/material.dart';

/// Экран управления ролями
class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = [
      {'name': 'Администратор', 'desc': 'Полный доступ к системе', 'count': 2},
      {'name': 'Менеджер', 'desc': 'Управление заявками', 'count': 5},
      {'name': 'Пользователь', 'desc': 'Базовый доступ', 'count': 15},
      {'name': 'Аудитор', 'desc': 'Просмотр истории', 'count': 1},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Роли')),
      body: ListView.builder(
        itemCount: roles.length,
        itemBuilder: (context, index) {
          final role = roles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.shield)),
              title: Text(role['name'] as String),
              subtitle: Text(role['desc'] as String),
              trailing: Chip(label: Text('${role['count']} чел.')),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}



