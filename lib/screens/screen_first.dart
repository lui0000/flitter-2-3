import 'package:flutter/material.dart';
import 'package:project1/screens/screen_second.dart';


class ScreenFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Первый экран')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenSecond()),
            );
          },
          child: Text('Перейти ко второму экрану'),
        ),
      ),
    );
  }
}