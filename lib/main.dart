import 'package:flutter/material.dart';
import 'core/access_requests_inherited.dart';
import 'features/access_requests/models/access_request.dart';
import 'features/access_requests/screens/access_requests_screen.dart';

void main() {
  runApp(const AccessApp());
}

class AccessApp extends StatelessWidget {
  const AccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Access IDM',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AccessRequestsWrapper(),
    );
  }
}

class AccessRequestsWrapper extends StatefulWidget {
  const AccessRequestsWrapper({super.key});

  @override
  State<AccessRequestsWrapper> createState() => _AccessRequestsWrapperState();
}

class _AccessRequestsWrapperState extends State<AccessRequestsWrapper> {
  final List<AccessRequest> _items = [];
  AccessRequest? _lastRemoved;
  int? _lastRemovedIndex;

  void _add(AccessRequest item) {
    setState(() {
      _items.add(item);
    });
  }

  void _toggleApproval(String id) {
    setState(() {
      final i = _items.indexWhere((e) => e.id == id);
      if (i == -1) return;
      final it = _items[i];
      _items[i] = it.copyWith(isApproved: !it.isApproved);
    });
  }

  void _remove(String id) {
    setState(() {
      final i = _items.indexWhere((e) => e.id == id);
      if (i == -1) return;
      _lastRemoved = _items[i];
      _lastRemovedIndex = i;
      _items.removeAt(i);
    });
  }

  void _undoRemove() {
    setState(() {
      if (_lastRemoved == null || _lastRemovedIndex == null) return;
      final insertIndex = _lastRemovedIndex!.clamp(0, _items.length);
      _items.insert(insertIndex, _lastRemoved!);
      _lastRemoved = null;
      _lastRemovedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AccessRequestsInherited(
      items: _items,
      onAdd: _add,
      onToggleApproval: _toggleApproval,
      onRemove: _remove,
      onUndoRemove: _undoRemove,
      child: const AccessRequestsScreen(),
    );
  }
}
