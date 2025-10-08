import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<String> staff = ['Иванов', 'Петров', 'Сидоров'];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список на ListView')),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Добавить сотрудника'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    setState(() {
                      staff.add(controller.text);
                      controller.clear();
                    });
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: staff
                  .map((person) => ListTile(
                title: Text(person),
                trailing: IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    setState(() => staff.remove(person));
                  },
                ),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
