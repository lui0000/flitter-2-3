import 'package:flutter/material.dart';
import '../models/access_request.dart';

class AccessRequestRow extends StatelessWidget {
  final AccessRequest request;
  final ValueChanged<String> onToggleApproval;
  final ValueChanged<String> onDelete;
  final VoidCallback? onTap;
  final bool dense;
  final Widget? leading;
  final Widget? trailingOverride;

  const AccessRequestRow({
    super.key,
    required this.request,
    required this.onToggleApproval,
    required this.onDelete,
    this.onTap,
    this.dense = false,
    this.leading,
    this.trailingOverride,
  });

  @override
  Widget build(BuildContext context) {
    final icon = request.isApproved ? Icons.verified : Icons.hourglass_empty;
    final color = request.isApproved ? Colors.green : Colors.orange;

    return ListTile(
      contentPadding: dense ? const EdgeInsets.symmetric(horizontal: 8) : null,
      leading: leading ?? Icon(icon, color: color),
      title: Text('${request.employee} • ${request.accessType}'),
      subtitle: Text(request.description),
      trailing: trailingOverride ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Переключить статус',
                icon: const Icon(Icons.swap_horiz),
                onPressed: () => onToggleApproval(request.id),
              ),
              IconButton(
                tooltip: 'Удалить заявку',
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(request.id),
              ),
            ],
          ),
      onTap: onTap,
    );
  }
}
