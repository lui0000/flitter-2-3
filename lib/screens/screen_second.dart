import 'package:flutter/material.dart';

class ScreenSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Второй экран')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Назад к первому экрану'),
          ),
          ElevatedButton(
            onPressed: () {
              context.replace('/third');
            },
            child: Text('Перейти на третий экран (replace)'),
          ),
        ],
      ),
    );
  }
}
