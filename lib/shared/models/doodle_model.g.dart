// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doodle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoodleModel _$DoodleModelFromJson(Map<String, dynamic> json) => _DoodleModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  ideaId: json['idea_id'] as String?,
  doodleData: json['doodle_data'] as List<dynamic>,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isActive: json['is_active'] as bool? ?? true,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
  isLiked: json['isLiked'] as bool? ?? false,
  authorName: json['authorName'] as String?,
);

Map<String, dynamic> _$DoodleModelToJson(_DoodleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'idea_id': instance.ideaId,
      'doodle_data': instance.doodleData,
      'tags': instance.tags,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'likes_count': instance.likesCount,
      'isLiked': instance.isLiked,
      'authorName': instance.authorName,
    };
