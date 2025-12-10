import 'package:equatable/equatable.dart';

class AccessRequestEntity extends Equatable {
  final String id;
  final String employee;
  final String accessType;
  final String description;
  final DateTime createdAt;
  final bool isApproved;

  const AccessRequestEntity({
    required this.id,
    required this.employee,
    required this.accessType,
    required this.description,
    required this.createdAt,
    required this.isApproved,
  });

  bool get isNew {
    final daysSinceCreation = DateTime.now().difference(createdAt).inDays;
    return daysSinceCreation < 1;
  }

  bool get requiresUrgentReview {
    final daysSinceCreation = DateTime.now().difference(createdAt).inDays;
    return !isApproved && daysSinceCreation > 3;
  }

  String get statusText {
    if (isApproved) return 'Одобрено';
    if (requiresUrgentReview) return 'Требует срочного рассмотрения';
    if (isNew) return 'Новый';
    return 'На рассмотрении';
  }

  @override
  List<Object?> get props => [id, employee, accessType, description, createdAt, isApproved];

  @override
  String toString() {
    return 'AccessRequestEntity(id: $id, employee: $employee, accessType: $accessType, isApproved: $isApproved)';
  }
}

