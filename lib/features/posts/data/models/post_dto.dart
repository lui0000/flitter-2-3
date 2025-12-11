import 'package:json_annotation/json_annotation.dart';

part 'post_dto.g.dart';

@JsonSerializable()
class PostDTO {
  final String id;
  final String title;
  final String body;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  PostDTO({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory PostDTO.fromJson(Map<String, dynamic> json) => _$PostDTOFromJson(json);
  Map<String, dynamic> toJson() => _$PostDTOToJson(this);
}

