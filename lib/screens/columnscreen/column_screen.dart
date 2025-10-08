import 'package:flutter/material.dart';

class ColumnScreen extends StatefulWidget {
  const ColumnScreen({super.key});

  @override
  State<ColumnScreen> createState() => _ColumnScreenState();
}

class _ColumnScreenState extends State<ColumnScreen> {
  List<String> staff = ['Иванов', 'Петров', 'Сидоров'];

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список на Column')),
      body: SingleChildScrollView(
        child: Column(
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
            ...staff.map((person) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(person, style: const TextStyle(fontSize: 18)),
                ),
                IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() => staff.remove(person));
                    }),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
