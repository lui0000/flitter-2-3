import 'package:flutter/material.dart';

class SeparatedScreen extends StatefulWidget {
  const SeparatedScreen({super.key});

  @override
  State<SeparatedScreen> createState() => _SeparatedScreenState();
}

class _SeparatedScreenState extends State<SeparatedScreen> {
  List<String> staff = ['Иванов', 'Петров', 'Сидоров'];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView.separated')),
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
            child: ListView.separated(
              itemCount: staff.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(staff[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    setState(() => staff.removeAt(index));
                  },
                ),
              ),
              separatorBuilder: (context, index) =>
              const Divider(height: 1, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
