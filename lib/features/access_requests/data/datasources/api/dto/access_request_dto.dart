class AccessRequestDTO {
  final String id;
  final String employee;
  final String accessType;
  final String description;
  final String createdAt;
  final bool isApproved;

  const AccessRequestDTO({
    required this.id,
    required this.employee,
    required this.accessType,
    required this.description,
    required this.createdAt,
    required this.isApproved,
  });

  factory AccessRequestDTO.fromJson(Map<String, dynamic> json) {
    return AccessRequestDTO(
      id: json['id'] as String,
      employee: json['employee'] as String,
      accessType: json['accessType'] as String,
      description: json['description'] as String? ?? '',
      createdAt: json['createdAt'] as String,
      isApproved: json['isApproved'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee': employee,
      'accessType': accessType,
      'description': description,
      'createdAt': createdAt,
      'isApproved': isApproved,
    };
  }
}

