// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_requests_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccessRequestsStore on _AccessRequestsStore, Store {
  late final _$itemsAtom =
      Atom(name: '_AccessRequestsStore.items', context: context);

  @override
  ObservableList<AccessRequest> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<AccessRequest> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$lastRemovedAtom =
      Atom(name: '_AccessRequestsStore.lastRemoved', context: context);

  @override
  AccessRequest? get lastRemoved {
    _$lastRemovedAtom.reportRead();
    return super.lastRemoved;
  }

  @override
  set lastRemoved(AccessRequest? value) {
    _$lastRemovedAtom.reportWrite(value, super.lastRemoved, () {
      super.lastRemoved = value;
    });
  }

  late final _$lastRemovedIndexAtom =
      Atom(name: '_AccessRequestsStore.lastRemovedIndex', context: context);

  @override
  int? get lastRemovedIndex {
    _$lastRemovedIndexAtom.reportRead();
    return super.lastRemovedIndex;
  }

  @override
  set lastRemovedIndex(int? value) {
    _$lastRemovedIndexAtom.reportWrite(value, super.lastRemovedIndex, () {
      super.lastRemovedIndex = value;
    });
  }

  late final _$_AccessRequestsStoreActionController =
      ActionController(name: '_AccessRequestsStore', context: context);

  @override
  void add(AccessRequest item) {
    final _$actionInfo = _$_AccessRequestsStoreActionController.startAction(
        name: '_AccessRequestsStore.add');
    try {
      return super.add(item);
    } finally {
      _$_AccessRequestsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleApproval(String id) {
    final _$actionInfo = _$_AccessRequestsStoreActionController.startAction(
        name: '_AccessRequestsStore.toggleApproval');
    try {
      return super.toggleApproval(id);
    } finally {
      _$_AccessRequestsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(String id) {
    final _$actionInfo = _$_AccessRequestsStoreActionController.startAction(
        name: '_AccessRequestsStore.remove');
    try {
      return super.remove(id);
    } finally {
      _$_AccessRequestsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void undoRemove() {
    final _$actionInfo = _$_AccessRequestsStoreActionController.startAction(
        name: '_AccessRequestsStore.undoRemove');
    try {
      return super.undoRemove();
    } finally {
      _$_AccessRequestsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
lastRemoved: ${lastRemoved},
lastRemovedIndex: ${lastRemovedIndex}
    ''';
  }
}
