import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/access_request.dart';

class AccessRequestsState {
  final List<AccessRequest> items;
  final AccessRequest? lastRemoved;
  final int? lastRemovedIndex;

  const AccessRequestsState({
    required this.items,
    this.lastRemoved,
    this.lastRemovedIndex,
  });

  AccessRequestsState copyWith({
    List<AccessRequest>? items,
    AccessRequest? lastRemoved,
    int? lastRemovedIndex,
  }) {
    return AccessRequestsState(
      items: items ?? this.items,
      lastRemoved: lastRemoved,
      lastRemovedIndex: lastRemovedIndex,
    );
  }
}

class AccessRequestsNotifier extends StateNotifier<AccessRequestsState> {
  AccessRequestsNotifier() : super(const AccessRequestsState(items: []));

  void add(AccessRequest item) {
    final updatedItems = List<AccessRequest>.from(state.items)..add(item);
    state = state.copyWith(items: updatedItems);
  }

  void toggleApproval(String id) {
    final updatedItems = state.items.map((item) {
      if (item.id == id) {
        return item.copyWith(isApproved: !item.isApproved);
      }
      return item;
    }).toList();
    state = state.copyWith(items: updatedItems);
  }

  void remove(String id) {
    final index = state.items.indexWhere((e) => e.id == id);
    if (index == -1) return;

    final removedItem = state.items[index];
    final updatedItems = List<AccessRequest>.from(state.items)..removeAt(index);

    state = state.copyWith(
      items: updatedItems,
      lastRemoved: removedItem,
      lastRemovedIndex: index,
    );
  }

  void undoRemove() {
    if (state.lastRemoved == null || state.lastRemovedIndex == null) return;

    final insertIndex = state.lastRemovedIndex!.clamp(0, state.items.length);
    final updatedItems = List<AccessRequest>.from(state.items)
      ..insert(insertIndex, state.lastRemoved!);

    state = state.copyWith(
      items: updatedItems,
      lastRemoved: null,
      lastRemovedIndex: null,
    );
  }
}

final accessRequestsProvider = StateNotifierProvider<AccessRequestsNotifier, AccessRequestsState>(
  (ref) => AccessRequestsNotifier(),
);

