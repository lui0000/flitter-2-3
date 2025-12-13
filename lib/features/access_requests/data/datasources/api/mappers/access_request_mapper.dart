import '../../../../domain/entities/access_request_entity.dart';
import '../dto/access_request_dto.dart';

class AccessRequestMapper {
  static AccessRequestEntity toEntity(AccessRequestDTO dto) {
    return AccessRequestEntity(
      id: dto.id,
      employee: dto.employee,
      accessType: dto.accessType,
      description: dto.description,
      createdAt: DateTime.parse(dto.createdAt),
      isApproved: dto.isApproved,
    );
  }

  static AccessRequestDTO fromEntity(AccessRequestEntity entity) {
    return AccessRequestDTO(
      id: entity.id,
      employee: entity.employee,
      accessType: entity.accessType,
      description: entity.description,
      createdAt: entity.createdAt.toIso8601String(),
      isApproved: entity.isApproved,
    );
  }

  static List<AccessRequestEntity> toEntityList(List<AccessRequestDTO> dtoList) {
    return dtoList.map((dto) => toEntity(dto)).toList();
  }

  static List<AccessRequestDTO> fromEntityList(List<AccessRequestEntity> entityList) {
    return entityList.map((entity) => fromEntity(entity)).toList();
  }
}

