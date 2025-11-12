import 'package:mobx/mobx.dart';
import '../models/access_request.dart';

part 'access_requests_store.g.dart';

class AccessRequestsStore = _AccessRequestsStore with _$AccessRequestsStore;

abstract class _AccessRequestsStore with Store {
  @observable
  ObservableList<AccessRequest> items = ObservableList<AccessRequest>();

  @observable
  AccessRequest? lastRemoved;

  @observable
  int? lastRemovedIndex;

  @action
  void add(AccessRequest item) {
    items.add(item);
  }

  @action
  void toggleApproval(String id) {
    final index = items.indexWhere((item) => item.id == id);
    if (index == -1) return;
    
    final item = items[index];
    items[index] = item.copyWith(isApproved: !item.isApproved);
  }

  @action
  void remove(String id) {
    final index = items.indexWhere((e) => e.id == id);
    if (index == -1) return;

    lastRemoved = items[index];
    lastRemovedIndex = index;
    items.removeAt(index);
  }

  @action
  void undoRemove() {
    if (lastRemoved == null || lastRemovedIndex == null) return;

    final insertIndex = lastRemovedIndex!.clamp(0, items.length);
    items.insert(insertIndex, lastRemoved!);
    lastRemoved = null;
    lastRemovedIndex = null;
  }
}

