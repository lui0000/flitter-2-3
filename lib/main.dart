import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'features/auth/state/auth_state.dart';
import 'features/access_requests/state/access_requests_state.dart';
import 'features/users/state/users_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => AccessRequestsState()),
        ChangeNotifierProvider(create: (_) => UsersState()),
      ],
      child: const AccessApp(),
    ),
  );
}

class AccessApp extends StatelessWidget {
  const AccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Слушаем состояние авторизации
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return MaterialApp(
      title: 'IDM Система',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      // Начальный маршрут зависит от авторизации
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
