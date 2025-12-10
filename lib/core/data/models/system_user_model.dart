import '../../domain/entities/system_user_entity.dart';

/// Data Model для системного пользователя
class SystemUserModel extends SystemUserEntity {
  const SystemUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.department,
    required super.role,
    required super.isActive,
    required super.createdAt,
  });

  /// Создание модели из Entity
  factory SystemUserModel.fromEntity(SystemUserEntity entity) {
    return SystemUserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      department: entity.department,
      role: entity.role,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
    );
  }

  /// Создание модели из JSON
  factory SystemUserModel.fromJson(Map<String, dynamic> json) {
    return SystemUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      department: json['department'] as String,
      role: json['role'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Конвертация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'department': department,
      'role': role,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Конвертация в Entity
  SystemUserEntity toEntity() {
    return SystemUserEntity(
      id: id,
      name: name,
      email: email,
      department: department,
      role: role,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}

