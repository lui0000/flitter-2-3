import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/access_requests/state/access_requests_state.dart';
import 'screens/horizontal_navigation_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AccessRequestsState(),
      child: const AccessApp(),
    ),
  );
}

class AccessApp extends StatelessWidget {
  const AccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Access IDM',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HorizontalNavigationScreen(),
    );
  }
}
