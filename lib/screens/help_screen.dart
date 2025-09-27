import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Справка', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        SizedBox(height: 12),
        Text('1. Профиль показывает имя и текущее значение счётчика.'),
        SizedBox(height: 6),
        Text('2. Задачи - добавление и удаление элементов списка.'),
        SizedBox(height: 6),
        Text('3. Статистика - увеличение счётчика по текущему шагу.'),
        SizedBox(height: 6),
        Text('4. Настройки - выбор шага, влияет на Статистику и Профиль.'),
      ],
    );
  }
}
