import 'package:flutter/material.dart';
import '../../../core/access_requests_inherited.dart';
import 'create_access_request_screen.dart';
import '../widgets/access_request_table.dart';

class AccessRequestsScreen extends StatelessWidget {
  const AccessRequestsScreen({super.key});

  void _deleteWithUndo(BuildContext context, String id) {
    final inherited = AccessRequestsInherited.of(context);
    if (inherited == null) return;

    inherited.onRemove(id);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Заявка удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => inherited.onUndoRemove(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inherited = AccessRequestsInherited.of(context);
    if (inherited == null) {
      return const Scaffold(
        body: Center(child: Text('Ошибка: нет доступа к данным')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Система выдачи доступов')),
      body: AccessRequestTable(
        items: inherited.items,
        onToggleApproval: inherited.onToggleApproval,
        onDelete: (id) => _deleteWithUndo(context, id),
        onItemTap: null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreateAccessRequestScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
