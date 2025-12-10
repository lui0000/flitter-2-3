import 'package:flutter/foundation.dart';
import '../models/system_user.dart';

class UsersState extends ChangeNotifier {
  final List<SystemUser> _users = [
    SystemUser(
      id: '1',
      name: 'Иванов Иван',
      email: 'ivanov@company.ru',
      department: 'IT отдел',
      role: 'Администратор',
      isActive: true,
      createdAt: DateTime(2024, 1, 15),
    ),
    SystemUser(
      id: '2',
      name: 'Петрова Мария',
      email: 'petrova@company.ru',
      department: 'Бухгалтерия',
      role: 'Пользователь',
      isActive: true,
      createdAt: DateTime(2024, 2, 20),
    ),
    SystemUser(
      id: '3',
      name: 'Сидоров Алексей',
      email: 'sidorov@company.ru',
      department: 'HR',
      role: 'Менеджер',
      isActive: false,
      createdAt: DateTime(2024, 3, 10),
    ),
  ];

  List<SystemUser> get users => List.unmodifiable(_users);

  void addUser({
    required String name,
    required String email,
    required String department,
    required String role,
  }) {
    final user = SystemUser(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      email: email,
      department: department,
      role: role,
      isActive: true,
      createdAt: DateTime.now(),
    );
    _users.add(user);
    notifyListeners();
  }

  void toggleActive(String id) {
    final index = _users.indexWhere((u) => u.id == id);
    if (index == -1) return;

    final user = _users[index];
    _users[index] = user.copyWith(isActive: !user.isActive);
    notifyListeners();
  }

  void removeUser(String id) {
    _users.removeWhere((u) => u.id == id);
    notifyListeners();
  }

  List<SystemUser> search(String query) {
    if (query.isEmpty) return users;
    final q = query.toLowerCase();
    return _users.where((u) => 
      u.name.toLowerCase().contains(q) ||
      u.email.toLowerCase().contains(q)
    ).toList();
  }
}


