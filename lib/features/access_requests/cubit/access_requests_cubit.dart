import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/access_request.dart';
import 'access_requests_state.dart';

class AccessRequestsCubit extends Cubit<AccessRequestsState> {
  AccessRequestsCubit() : super(const AccessRequestsState(items: []));

  void add(AccessRequest item) {
    final updatedItems = List<AccessRequest>.from(state.items)..add(item);
    emit(state.copyWith(items: updatedItems));
  }

  void toggleApproval(String id) {
    final updatedItems = state.items.map((item) {
      if (item.id == id) {
        return item.copyWith(isApproved: !item.isApproved);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedItems));
  }

  void remove(String id) {
    final index = state.items.indexWhere((e) => e.id == id);
    if (index == -1) return;

    final removedItem = state.items[index];
    final updatedItems = List<AccessRequest>.from(state.items)..removeAt(index);

    emit(state.copyWith(
      items: updatedItems,
      lastRemoved: removedItem,
      lastRemovedIndex: index,
    ));
  }

  void undoRemove() {
    if (state.lastRemoved == null || state.lastRemovedIndex == null) return;

    final insertIndex = state.lastRemovedIndex!.clamp(0, state.items.length);
    final updatedItems = List<AccessRequest>.from(state.items)
      ..insert(insertIndex, state.lastRemoved!);

    emit(state.copyWith(
      items: updatedItems,
      lastRemoved: null,
      lastRemovedIndex: null,
    ));
  }
}
