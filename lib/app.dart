import 'package:flutter/material.dart';
import 'features/access_requests/view/access_requests_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Access IDM',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AccessRequestsPage(),
    );
  }
}
