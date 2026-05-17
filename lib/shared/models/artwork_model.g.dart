// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArtworkModel _$ArtworkModelFromJson(Map<String, dynamic> json) =>
    _ArtworkModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      authorName: json['authorName'] as String?,
      ideaId: json['idea_id'] as String?,
      doodleId: json['doodle_id'] as String?,
      previewUrl: json['preview_url'] as String?,
      externalLink: json['external_link'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$ArtworkModelToJson(_ArtworkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'authorName': instance.authorName,
      'idea_id': instance.ideaId,
      'doodle_id': instance.doodleId,
      'preview_url': instance.previewUrl,
      'external_link': instance.externalLink,
      'tags': instance.tags,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'likes_count': instance.likesCount,
      'isLiked': instance.isLiked,
    };
