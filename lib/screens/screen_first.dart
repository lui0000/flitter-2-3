import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ScreenFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Первый экран')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/second');
          },
          child: Text('Перейти ко второму экрану'),
        ),
      ),
    );
  }
}
