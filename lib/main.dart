import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_router.dart';
import 'core/storage/shared_prefs_data_source.dart';
import 'core/storage/secure_storage_data_source.dart';
import 'core/database/sql_database_helper.dart';
import 'core/database/hive_storage_helper.dart';
import 'core/database/drift/app_database.dart';
import 'features/auth/state/auth_state.dart';
import 'features/access_requests/state/access_requests_state.dart';
import 'features/users/state/users_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final sharedPrefsDataSource = SharedPrefsDataSource(prefs);

  const secureStorage = FlutterSecureStorage();
  final secureStorageDataSource = SecureStorageDataSource(secureStorage);

  final sqlDatabase = SqlDatabaseHelper();
  
  await HiveStorageHelper.init();
  final hiveStorage = HiveStorageHelper();

  final driftDatabase = AppDatabase();

  runApp(
    MultiProvider(
      providers: [
        Provider<SharedPrefsDataSource>.value(value: sharedPrefsDataSource),
        Provider<SecureStorageDataSource>.value(value: secureStorageDataSource),
        Provider<SqlDatabaseHelper>.value(value: sqlDatabase),
        Provider<HiveStorageHelper>.value(value: hiveStorage),
        Provider<AppDatabase>.value(value: driftDatabase),
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
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return MaterialApp(
      title: 'IDM Система',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
