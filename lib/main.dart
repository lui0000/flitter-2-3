import 'package:flutter/material.dart';
import 'core/service_locator.dart';
import 'features/access_requests/screens/access_requests_screen.dart';

void main() {
  setupServiceLocator();
  runApp(const AccessApp());
}

class AccessApp extends StatelessWidget {
  const AccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Access IDM',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AccessRequestsScreen(),
    );
  }
}
