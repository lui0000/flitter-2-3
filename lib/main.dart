import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project1/screens/screen_first.dart';
import 'package:project1/screens/screen_second.dart';
import 'package:project1/screens/screen_third.dart';


void main() {
  runApp(MyApp());
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ScreenFirst(),
    ),
    GoRoute(
      path: '/second',
      builder: (context, state) => ScreenSecond(),
    ),
    GoRoute(
      path: '/third',
      builder: (context, state) => ScreenThird(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
