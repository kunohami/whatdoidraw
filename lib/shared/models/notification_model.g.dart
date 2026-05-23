// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationActor _$NotificationActorFromJson(Map<String, dynamic> json) =>
    _NotificationActor(
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$NotificationActorToJson(_NotificationActor instance) =>
    <String, dynamic>{
      'username': instance.username,
      'avatar_url': instance.avatarUrl,
    };

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      actorId: json['actor_id'] as String,
      actor: json['actor'] == null
          ? null
          : NotificationActor.fromJson(json['actor'] as Map<String, dynamic>),
      type: json['type'] as String,
      targetId: json['target_id'] as String,
      isRead: json['is_read'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'actor_id': instance.actorId,
      'actor': instance.actor,
      'type': instance.type,
      'target_id': instance.targetId,
      'is_read': instance.isRead,
      'created_at': instance.createdAt?.toIso8601String(),
    };
