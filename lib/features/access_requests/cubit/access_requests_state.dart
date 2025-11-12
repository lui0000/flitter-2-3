import 'package:equatable/equatable.dart';
import '../models/access_request.dart';

class AccessRequestsState extends Equatable {
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

  @override
  List<Object?> get props => [items, lastRemoved, lastRemovedIndex];
}
