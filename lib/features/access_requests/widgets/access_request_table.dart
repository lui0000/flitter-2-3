import 'package:flutter/material.dart';
import '../models/access_request.dart';
import 'access_request_row.dart';

class AccessRequestTable extends StatelessWidget {
  final List<AccessRequest> items;
  final ValueChanged<String> onToggleApproval;
  final ValueChanged<String> onDelete;
  final ValueChanged<String>? onItemTap;

  const AccessRequestTable({
    super.key,
    required this.items,
    required this.onToggleApproval,
    required this.onDelete,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Заявок нет'));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final r = items[index];
        return Dismissible(
          key: ValueKey(r.id),
          background: Container(color: Colors.red),
          onDismissed: (_) => onDelete(r.id),
          child: AccessRequestRow(
            request: r,
            onToggleApproval: onToggleApproval,
            onDelete: onDelete,
            onTap: onItemTap == null ? null : () => onItemTap!(r.id),
          ),
        );
      },
    );
  }
}
