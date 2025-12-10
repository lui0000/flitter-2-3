/// Domain Entity: Заявка на доступ
/// Чистая бизнес-модель без зависимостей
class AccessRequestEntity {
  final String id;
  final String employeeName;
  final String accessType;
  final String description;
  final DateTime createdAt;
  final AccessRequestStatus status;

  const AccessRequestEntity({
    required this.id,
    required this.employeeName,
    required this.accessType,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  AccessRequestEntity copyWith({
    String? id,
    String? employeeName,
    String? accessType,
    String? description,
    DateTime? createdAt,
    AccessRequestStatus? status,
  }) {
    return AccessRequestEntity(
      id: id ?? this.id,
      employeeName: employeeName ?? this.employeeName,
      accessType: accessType ?? this.accessType,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessRequestEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Статус заявки на доступ
enum AccessRequestStatus {
  pending,    // На рассмотрении
  approved,   // Одобрена
  rejected,   // Отклонена
}

