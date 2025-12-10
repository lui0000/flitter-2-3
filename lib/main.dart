import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'features/auth/state/auth_state.dart';
import 'features/users/state/users_state.dart';
import 'features/access_requests/presentation/bloc/access_requests_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  // Инициализация Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Dependency Injection
  await di.init();

  runApp(const AccessApp());
}

class AccessApp extends StatelessWidget {
  const AccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Старые состояния (будут постепенно мигрированы на Bloc)
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => UsersState()),

        // Новый Bloc для Access Requests (Clean Architecture)
        BlocProvider(
          create: (_) => di.sl<AccessRequestsBloc>(),
        ),
      ],
      child: const _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    // Слушаем состояние авторизации
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return MaterialApp(
      title: 'IDM Система',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        
        // Настройка темы для лучшего внешнего вида
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // Начальный маршрут зависит от авторизации
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
      onGenerateRoute: AppRouter.generateRoute,
      
      debugShowCheckedModeBanner: false,
    );
  }
}
