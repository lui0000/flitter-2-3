import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Экраны
import 'features/auth/screens/login_screen.dart';
import 'features/access_requests/presentation/pages/access_requests_page.dart';
import 'features/access_requests/presentation/pages/create_access_request_page.dart';
import 'features/access_requests/presentation/bloc/access_requests_bloc.dart';
import 'features/users/screens/users_screen.dart';
import 'features/roles/screens/roles_screen.dart';
import 'features/resources/screens/resources_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/audit/screens/audit_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/home/screens/home_screen.dart';

// Dependency Injection
import 'injection_container.dart' as di;

/// Класс маршрутов приложения
class AppRoutes {
  static const String login = '/login';
  static const String home = '/';
  static const String accessRequests = '/access-requests';
  static const String createAccessRequest = '/access-requests/create';
  static const String users = '/users';
  static const String roles = '/roles';
  static const String resources = '/resources';
  static const String profile = '/profile';
  static const String audit = '/audit';
  static const String settings = '/settings';
}

/// Генератор маршрутов
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.accessRequests:
        // Оборачиваем в BlocProvider для предоставления Bloc
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => di.sl<AccessRequestsBloc>(),
            child: const AccessRequestsPage(),
          ),
        );

      case AppRoutes.createAccessRequest:
        // Здесь используем существующий Bloc из родительского контекста
        // Если его нет - создаем новый
        return MaterialPageRoute(
          builder: (context) {
            // Пробуем получить Bloc из контекста
            try {
              final bloc = context.read<AccessRequestsBloc>();
              return BlocProvider.value(
                value: bloc,
                child: const CreateAccessRequestPage(),
              );
            } catch (e) {
              // Если Bloc не найден - создаем новый
              return BlocProvider(
                create: (_) => di.sl<AccessRequestsBloc>(),
                child: const CreateAccessRequestPage(),
              );
            }
          },
        );

      case AppRoutes.users:
        return MaterialPageRoute(builder: (_) => const UsersScreen());

      case AppRoutes.roles:
        return MaterialPageRoute(builder: (_) => const RolesScreen());

      case AppRoutes.resources:
        return MaterialPageRoute(builder: (_) => const ResourcesScreen());

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.audit:
        return MaterialPageRoute(builder: (_) => const AuditScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Маршрут ${settings.name} не найден'),
            ),
          ),
        );
    }
  }
}
