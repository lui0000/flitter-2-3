import 'package:flutter/material.dart';
import '../../../core/service_locator.dart';
import '../state/access_requests_state.dart';
import 'create_access_request_screen.dart';
import '../widgets/access_request_table.dart';

class AccessRequestsScreen extends StatefulWidget {
  const AccessRequestsScreen({super.key});

  @override
  State<AccessRequestsScreen> createState() => _AccessRequestsScreenState();
}

class _AccessRequestsScreenState extends State<AccessRequestsScreen> {
  late final AccessRequestsState _state;

  @override
  void initState() {
    super.initState();
    _state = getIt<AccessRequestsState>();
    _state.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _state.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    setState(() {});
  }

  void _deleteWithUndo(String id) {
    _state.remove(id);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Заявка удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => _state.undoRemove(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Система выдачи доступов')),
      body: AccessRequestTable(
        items: _state.items,
        onToggleApproval: _state.toggleApproval,
        onDelete: _deleteWithUndo,
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
