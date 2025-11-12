import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/access_requests_store.dart';
import '../widgets/access_request_table.dart';
import '../screens/create_access_request_screen.dart';

class AccessRequestsView extends StatelessWidget {
  final AccessRequestsStore store;

  const AccessRequestsView({super.key, required this.store});

  void _deleteWithUndo(BuildContext context, String id) {
    store.remove(id);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Заявка удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => store.undoRemove(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Система выдачи доступов')),
      body: Observer(
        builder: (_) => AccessRequestTable(
          items: store.items,
          onToggleApproval: (id) => store.toggleApproval(id),
          onDelete: (id) => _deleteWithUndo(context, id),
          onItemTap: null,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CreateAccessRequestScreen(store: store),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
