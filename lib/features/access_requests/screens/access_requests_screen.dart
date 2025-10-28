import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/access_requests_state.dart';
import 'create_access_request_screen.dart';
import '../widgets/access_request_table.dart';

class AccessRequestsScreen extends StatelessWidget {
  const AccessRequestsScreen({super.key});

  void _deleteWithUndo(BuildContext context, String id) {
    final state = context.read<AccessRequestsState>();
    state.remove(id);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Заявка удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => context.read<AccessRequestsState>().undoRemove(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessRequestsState>(
      builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Система выдачи доступов')),
          body: AccessRequestTable(
            items: state.items,
            onToggleApproval: (id) => state.toggleApproval(id),
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
      },
    );
  }
}
