// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IdeaModel _$IdeaModelFromJson(Map<String, dynamic> json) => _IdeaModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  content: json['content'] as String,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isActive: json['is_active'] as bool? ?? true,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$IdeaModelToJson(_IdeaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'content': instance.content,
      'tags': instance.tags,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
    };
