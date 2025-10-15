import 'package:flutter/material.dart';
import 'features/access_requests/screens/access_requests_screen.dart';
import 'features/access_requests/state/access_requests_state.dart';

void main() {
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
