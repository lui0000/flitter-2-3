import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({
    super.key,
    required this.counter,
    required this.step,
    required this.onIncrement,
  });

  final int counter;
  final int step;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Счётчик: $counter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 12),
          Text('Шаг инкремента: +$step'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onIncrement,
            child: Text('Увеличить на $step'),
          ),
        ],
      ),
    );
  }
}
