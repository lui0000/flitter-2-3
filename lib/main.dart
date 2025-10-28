import 'package:flutter/material.dart';
import 'package:project1/screens/screen_first.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenFirst(),
    );
  }
}