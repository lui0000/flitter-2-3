import 'package:flutter/material.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employees = [
      {'name': 'Иванов Иван', 'position': 'Разработчик'},
      {'name': 'Петрова Мария', 'position': 'Менеджер'},
      {'name': 'Сидоров Петр', 'position': 'Администратор'},
      {'name': 'Козлова Анна', 'position': 'Аналитик'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сотрудники'),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return ListTile(
            title: Text(employee['name']!),
            subtitle: Text(employee['position']!),
            onTap: () {
              // Вертикальная навигация - push
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeDetailScreen(
                    name: employee['name']!,
                    position: employee['position']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EmployeeDetailScreen extends StatelessWidget {
  final String name;
  final String position;

  const EmployeeDetailScreen({
    super.key,
    required this.name,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Информация о сотруднике',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('ФИО: $name', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Должность: $position', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Вертикальная навигация - pop
                Navigator.pop(context);
              },
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

