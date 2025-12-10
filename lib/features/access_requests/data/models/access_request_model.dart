import '../../domain/entities/access_request_entity.dart';

class AccessRequestModel extends AccessRequestEntity {
  const AccessRequestModel({
    required super.id,
    required super.employee,
    required super.accessType,
    required super.description,
    required super.createdAt,
    required super.isApproved,
  });

  factory AccessRequestModel.fromJson(Map<String, dynamic> json) {
    return AccessRequestModel(
      id: json['id'] as String,
      employee: json['employee'] as String,
      accessType: json['accessType'] as String,
      description: json['description'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      isApproved: json['isApproved'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee': employee,
      'accessType': accessType,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'isApproved': isApproved,
    };
  }

  factory AccessRequestModel.fromEntity(AccessRequestEntity entity) {
    return AccessRequestModel(
      id: entity.id,
      employee: entity.employee,
      accessType: entity.accessType,
      description: entity.description,
      createdAt: entity.createdAt,
      isApproved: entity.isApproved,
    );
  }

  AccessRequestModel copyWith({
    String? id,
    String? employee,
    String? accessType,
    String? description,
    DateTime? createdAt,
    bool? isApproved,
  }) {
    return AccessRequestModel(
      id: id ?? this.id,
      employee: employee ?? this.employee,
      accessType: accessType ?? this.accessType,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isApproved: isApproved ?? this.isApproved,
    );
  }

  @override
  String toString() {
    return 'AccessRequestModel(id: $id, employee: $employee, accessType: $accessType, isApproved: $isApproved)';
  }
}

