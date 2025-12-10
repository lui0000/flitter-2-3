import '../../domain/entities/access_request_entity.dart';

/// Data Model для заявки на доступ
class AccessRequestModel extends AccessRequestEntity {
  const AccessRequestModel({
    required super.id,
    required super.employeeName,
    required super.accessType,
    required super.description,
    required super.createdAt,
    required super.status,
  });

  /// Создание модели из Entity
  factory AccessRequestModel.fromEntity(AccessRequestEntity entity) {
    return AccessRequestModel(
      id: entity.id,
      employeeName: entity.employeeName,
      accessType: entity.accessType,
      description: entity.description,
      createdAt: entity.createdAt,
      status: entity.status,
    );
  }

  /// Создание модели из JSON
  factory AccessRequestModel.fromJson(Map<String, dynamic> json) {
    return AccessRequestModel(
      id: json['id'] as String,
      employeeName: json['employeeName'] as String,
      accessType: json['accessType'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: _statusFromString(json['status'] as String),
    );
  }

  /// Конвертация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeName': employeeName,
      'accessType': accessType,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'status': _statusToString(status),
    };
  }

  /// Конвертация в Entity
  AccessRequestEntity toEntity() {
    return AccessRequestEntity(
      id: id,
      employeeName: employeeName,
      accessType: accessType,
      description: description,
      createdAt: createdAt,
      status: status,
    );
  }

  static AccessRequestStatus _statusFromString(String status) {
    switch (status) {
      case 'pending':
        return AccessRequestStatus.pending;
      case 'approved':
        return AccessRequestStatus.approved;
      case 'rejected':
        return AccessRequestStatus.rejected;
      default:
        return AccessRequestStatus.pending;
    }
  }

  static String _statusToString(AccessRequestStatus status) {
    switch (status) {
      case AccessRequestStatus.pending:
        return 'pending';
      case AccessRequestStatus.approved:
        return 'approved';
      case AccessRequestStatus.rejected:
        return 'rejected';
    }
  }
}

