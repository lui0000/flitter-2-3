// import 'package:flutter/foundation.dart';
// import '../models/access_request.dart';
//
// class AccessRequestsState extends ChangeNotifier {
//   final List<AccessRequest> _items = [];
//   AccessRequest? _lastRemoved;
//   int? _lastRemovedIndex;
//
//   List<AccessRequest> get items => List.unmodifiable(_items);
//
//   void createRequest({
//     required String employee,
//     required String accessType,
//     String description = '',
//   }) {
//     final now = DateTime.now();
//     final item = AccessRequest(
//       id: now.microsecondsSinceEpoch.toString(),
//       employee: employee,
//       accessType: accessType,
//       description: description,
//       createdAt: now,
//       isApproved: false,
//     );
//     _items.add(item);
//     notifyListeners();
//   }
//
//   void toggleApproval(String id) {
//     final i = _items.indexWhere((e) => e.id == id);
//     if (i == -1) return;
//     final it = _items[i];
//     _items[i] = it.copyWith(isApproved: !it.isApproved);
//     notifyListeners();
//   }
//   void add(AccessRequest item) {
//     _items.add(item);
//     notifyListeners();
//   }
//
//   void remove(String id) {
//     final i = _items.indexWhere((e) => e.id == id);
//     if (i == -1) return;
//     _lastRemoved = _items[i];
//     _lastRemovedIndex = i;
//     _items.removeAt(i);
//     notifyListeners();
//   }
//
//   void undoRemove() {
//     if (_lastRemoved == null || _lastRemovedIndex == null) return;
//     final insertIndex = _lastRemovedIndex!.clamp(0, _items.length);
//     _items.insert(insertIndex, _lastRemoved!);
//     _lastRemoved = null;
//     _lastRemovedIndex = null;
//     notifyListeners();
//   }
// }
