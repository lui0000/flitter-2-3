import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({
    super.key,
    required this.tasks,
    required this.onAdd,
    required this.onRemoveAt,
  });

  final List<String> tasks;
  final void Function(String) onAdd;
  final void Function(int) onRemoveAt;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Новая задача',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    widget.onAdd(text);
                    _controller.clear();
                  }
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
        ),
        const Divider(height: 0),
        Expanded(
          child: ListView.separated(
            itemCount: widget.tasks.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, i) {
              final task = widget.tasks[i];
              return ListTile(
                title: Text(task),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => widget.onRemoveAt(i),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
