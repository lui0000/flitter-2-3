import 'package:flutter/material.dart';

/// Экран истории/аудита действий
class AuditScreen extends StatelessWidget {
  const AuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      {'action': 'Вход в систему', 'user': 'ivanov@company.ru', 'time': '10:30'},
      {'action': 'Создана заявка #123', 'user': 'petrova@company.ru', 'time': '10:25'},
      {'action': 'Одобрена заявка #120', 'user': 'admin@company.ru', 'time': '10:15'},
      {'action': 'Добавлен пользователь', 'user': 'admin@company.ru', 'time': '09:50'},
      {'action': 'Изменена роль', 'user': 'admin@company.ru', 'time': '09:30'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('История действий')),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(log['action']!),
            subtitle: Text(log['user']!),
            trailing: Text(log['time']!, style: Theme.of(context).textTheme.bodySmall),
          );
        },
      ),
    );
  }
}

