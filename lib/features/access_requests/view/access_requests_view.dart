import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/access_requests_cubit.dart';
import '../cubit/access_requests_state.dart' as cubit_state;
import '../widgets/access_request_table.dart';
import '../screens/create_access_request_screen.dart';

class AccessRequestsView extends StatelessWidget {
  const AccessRequestsView({super.key});

  void _deleteWithUndo(BuildContext context, String id) {
    context.read<AccessRequestsCubit>().remove(id);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Заявка удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => context.read<AccessRequestsCubit>().undoRemove(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Система выдачи доступов')),
      body: BlocBuilder<AccessRequestsCubit, cubit_state.AccessRequestsState>(
        bloc: context.read<AccessRequestsCubit>(),
        builder: (context, state) {
          return AccessRequestTable(
            items: state.items,
            onToggleApproval: (id) => context.read<AccessRequestsCubit>().toggleApproval(id),
            onDelete: (id) => _deleteWithUndo(context, id),
            onItemTap: null,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<AccessRequestsCubit>(),
                child: const CreateAccessRequestScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
