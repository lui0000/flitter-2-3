import 'package:flutter/material.dart';
import '../features/access_requests/models/access_request.dart';

class AccessRequestsInherited extends InheritedWidget {
  final List<AccessRequest> items;
  final Function(AccessRequest) onAdd;
  final Function(String) onToggleApproval;
  final Function(String) onRemove;
  final Function() onUndoRemove;

  const AccessRequestsInherited({
    super.key,
    required this.items,
    required this.onAdd,
    required this.onToggleApproval,
    required this.onRemove,
    required this.onUndoRemove,
    required super.child,
  });

  static AccessRequestsInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AccessRequestsInherited>();
  }

  @override
  bool updateShouldNotify(AccessRequestsInherited oldWidget) {
    return oldWidget.items != items;
  }
}
