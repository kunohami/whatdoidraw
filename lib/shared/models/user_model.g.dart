// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  avatarUrl: json['avatar_url'] as String?,
  isArtist: json['is_artist'] as bool? ?? false,
  portfolioUrl: json['portfolio_url'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar_url': instance.avatarUrl,
      'is_artist': instance.isArtist,
      'portfolio_url': instance.portfolioUrl,
      'created_at': instance.createdAt?.toIso8601String(),
    };
