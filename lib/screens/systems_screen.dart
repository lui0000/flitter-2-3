import 'package:flutter/material.dart';

class SystemsScreen extends StatelessWidget {
  const SystemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final systems = [
      'CRM Система',
      'ERP Система',
      'HRM Система',
      'Документооборот',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Системы'),
      ),
      body: ListView.builder(
        itemCount: systems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.computer),
            title: Text(systems[index]),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Выбрана: ${systems[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}

