class AccessRequest {
  final String id;
  final String employee;
  final String accessType;
  final String description;
  final DateTime createdAt;
  final bool isApproved;

  const AccessRequest({
    required this.id,
    required this.employee,
    required this.accessType,
    required this.description,
    required this.createdAt,
    required this.isApproved,
  });

  AccessRequest copyWith({
    String? id,
    String? employee,
    String? accessType,
    String? description,
    DateTime? createdAt,
    bool? isApproved,
  }) {
    return AccessRequest(
      id: id ?? this.id,
      employee: employee ?? this.employee,
      accessType: accessType ?? this.accessType,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isApproved: isApproved ?? this.isApproved,
    );
  }
}

