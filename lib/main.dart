import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/access_requests/state/access_requests_state.dart';
import 'features/access_requests/screens/access_requests_screen.dart';
import 'screens/home_screen.dart';
import 'screens/employees_screen.dart';
import 'screens/systems_screen.dart';
import 'screens/settings_screen.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/requests': (context) => const AccessRequestsScreen(),
        '/employees': (context) => const EmployeesScreen(),
        '/systems': (context) => const SystemsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/horizontal': (context) => const HorizontalNavigationScreen(),
      },
    );
  }
}
