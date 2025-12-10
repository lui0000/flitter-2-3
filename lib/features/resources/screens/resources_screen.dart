import 'package:flutter/material.dart';

/// Экран управления ресурсами/системами
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      {'name': '1C Бухгалтерия', 'type': 'ERP', 'active': true},
      {'name': 'Bitrix24', 'type': 'CRM', 'active': true},
      {'name': 'Active Directory', 'type': 'Каталог', 'active': true},
      {'name': 'Файловый сервер', 'type': 'Хранилище', 'active': false},
      {'name': 'Jira', 'type': 'Задачи', 'active': true},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Ресурсы')),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final res = resources[index];
          final active = res['active'] as bool;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: active ? Colors.green : Colors.grey,
                child: const Icon(Icons.dns, color: Colors.white),
              ),
              title: Text(res['name'] as String),
              subtitle: Text(res['type'] as String),
              trailing: Switch(value: active, onChanged: (_) {}),
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

