import 'package:flutter/material.dart';

class ScreenThird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Третий экран')),
      body: Center(
        child: Text('Это третий экран маршрутизированной навигации'),
      ),
    );
  }
}
