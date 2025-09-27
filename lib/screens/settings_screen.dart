import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.step, required this.onStepChanged});

  final int step;
  final void Function(int) onStepChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Настройки счётчика', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Шаг:'),
              const SizedBox(width: 12),
              DropdownButton<int>(
                value: step,
                items: const [1, 2, 3, 5, 10]
                    .map((v) => DropdownMenuItem(value: v, child: Text('$v')))
                    .toList(),
                onChanged: (v) {
                  if (v != null) onStepChanged(v);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Подсказка: шаг влияет на экран Статистика и на отображение в Профиле.'),
        ],
      ),
    );
  }
}
