import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationActor with _$NotificationActor {
  const factory NotificationActor({
    required String username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _NotificationActor;

  factory NotificationActor.fromJson(Map<String, dynamic> json) =>
      _$NotificationActorFromJson(json);
}

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'actor_id') required String actorId,
    NotificationActor? actor,
    required String type,
    @JsonKey(name: 'target_id') required String targetId,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
