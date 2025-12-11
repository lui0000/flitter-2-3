import 'package:flutter/material.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/access_requests/screens/access_requests_screen.dart';
import 'features/access_requests/screens/create_access_request_screen.dart';
import 'features/users/screens/users_screen.dart';
import 'features/roles/screens/roles_screen.dart';
import 'features/resources/screens/resources_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/audit/screens/audit_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/demo/screens/api_demo_screen.dart';

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
  static const String apiDemo = '/api-demo';
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
        return MaterialPageRoute(builder: (_) => const AccessRequestsScreen());

      case AppRoutes.createAccessRequest:
        return MaterialPageRoute(builder: (_) => const CreateAccessRequestScreen());

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

      case AppRoutes.apiDemo:
        return MaterialPageRoute(builder: (_) => const ApiDemoScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Маршрут ${settings.name} не найден')),
          ),
        );
    }
  }
}

