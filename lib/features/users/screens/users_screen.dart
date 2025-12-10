import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/users_state.dart';
import '../models/system_user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showAddUserDialog() {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final deptCtrl = TextEditingController();
    String selectedRole = 'Пользователь';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Новый пользователь'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'ФИО'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: deptCtrl,
                decoration: const InputDecoration(labelText: 'Отдел'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(labelText: 'Роль'),
                items: const [
                  DropdownMenuItem(value: 'Пользователь', child: Text('Пользователь')),
                  DropdownMenuItem(value: 'Менеджер', child: Text('Менеджер')),
                  DropdownMenuItem(value: 'Администратор', child: Text('Администратор')),
                ],
                onChanged: (v) => selectedRole = v ?? 'Пользователь',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && emailCtrl.text.isNotEmpty) {
                context.read<UsersState>().addUser(
                  name: nameCtrl.text.trim(),
                  email: emailCtrl.text.trim(),
                  department: deptCtrl.text.trim(),
                  role: selectedRole,
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользователи'),
      ),
      body: Column(
        children: [
          // Поле поиска
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Поиск по имени или email...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),

          // Список пользователей
          Expanded(
            child: Consumer<UsersState>(
              builder: (context, state, _) {
                final users = state.search(_searchQuery);

                if (users.isEmpty) {
                  return const Center(
                    child: Text('Пользователи не найдены'),
                  );
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return _UserCard(
                      user: user,
                      onToggleActive: () => state.toggleActive(user.id),
                      onDelete: () => state.removeUser(user.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

/// Карточка пользователя
class _UserCard extends StatelessWidget {
  final SystemUser user;
  final VoidCallback onToggleActive;
  final VoidCallback onDelete;

  const _UserCard({
    required this.user,
    required this.onToggleActive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: user.isActive ? Colors.green : Colors.grey,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(user.name),
        subtitle: Text('${user.email}\n${user.department} • ${user.role}'),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Кнопка активации/деактивации
            IconButton(
              icon: Icon(
                user.isActive ? Icons.toggle_on : Icons.toggle_off,
                color: user.isActive ? Colors.green : Colors.grey,
                size: 32,
              ),
              onPressed: onToggleActive,
              tooltip: user.isActive ? 'Деактивировать' : 'Активировать',
            ),
            // Кнопка удаления
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
              tooltip: 'Удалить',
            ),
          ],
        ),
      ),
    );
  }
}


