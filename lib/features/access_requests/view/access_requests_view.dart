import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/access_requests_provider.dart';
import '../widgets/access_request_table.dart';
import '../screens/create_access_request_screen.dart';

class AccessRequestsView extends ConsumerWidget {
  const AccessRequestsView({super.key});

  void _deleteWithUndo(BuildContext context, WidgetRef ref, String id) {
    ref.read(accessRequestsProvider.notifier).remove(id);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Заявка удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => ref.read(accessRequestsProvider.notifier).undoRemove(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accessRequestsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Система выдачи доступов')),
      body: AccessRequestTable(
        items: state.items,
        onToggleApproval: (id) => ref.read(accessRequestsProvider.notifier).toggleApproval(id),
        onDelete: (id) => _deleteWithUndo(context, ref, id),
        onItemTap: null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateAccessRequestScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
