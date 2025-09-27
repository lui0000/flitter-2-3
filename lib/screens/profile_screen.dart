import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userName, required this.counter});

  final String userName;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Пользователь: $userName', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          Text('Текущий счётчик: $counter',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
