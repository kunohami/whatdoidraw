// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationActor {

 String get username;@JsonKey(name: 'avatar_url') String? get avatarUrl;
/// Create a copy of NotificationActor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationActorCopyWith<NotificationActor> get copyWith => _$NotificationActorCopyWithImpl<NotificationActor>(this as NotificationActor, _$identity);

  /// Serializes this NotificationActor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationActor&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,avatarUrl);

@override
String toString() {
  return 'NotificationActor(username: $username, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $NotificationActorCopyWith<$Res>  {
  factory $NotificationActorCopyWith(NotificationActor value, $Res Function(NotificationActor) _then) = _$NotificationActorCopyWithImpl;
@useResult
$Res call({
 String username,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class _$NotificationActorCopyWithImpl<$Res>
    implements $NotificationActorCopyWith<$Res> {
  _$NotificationActorCopyWithImpl(this._self, this._then);

  final NotificationActor _self;
  final $Res Function(NotificationActor) _then;

/// Create a copy of NotificationActor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationActor].
extension NotificationActorPatterns on NotificationActor {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationActor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationActor() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationActor value)  $default,){
final _that = this;
switch (_that) {
case _NotificationActor():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationActor value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationActor() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationActor() when $default != null:
return $default(_that.username,_that.avatarUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username, @JsonKey(name: 'avatar_url')  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _NotificationActor():
return $default(_that.username,_that.avatarUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _NotificationActor() when $default != null:
return $default(_that.username,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationActor implements NotificationActor {
  const _NotificationActor({required this.username, @JsonKey(name: 'avatar_url') this.avatarUrl});
  factory _NotificationActor.fromJson(Map<String, dynamic> json) => _$NotificationActorFromJson(json);

@override final  String username;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;

/// Create a copy of NotificationActor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationActorCopyWith<_NotificationActor> get copyWith => __$NotificationActorCopyWithImpl<_NotificationActor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationActorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationActor&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,avatarUrl);

@override
String toString() {
  return 'NotificationActor(username: $username, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$NotificationActorCopyWith<$Res> implements $NotificationActorCopyWith<$Res> {
  factory _$NotificationActorCopyWith(_NotificationActor value, $Res Function(_NotificationActor) _then) = __$NotificationActorCopyWithImpl;
@override @useResult
$Res call({
 String username,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class __$NotificationActorCopyWithImpl<$Res>
    implements _$NotificationActorCopyWith<$Res> {
  __$NotificationActorCopyWithImpl(this._self, this._then);

  final _NotificationActor _self;
  final $Res Function(_NotificationActor) _then;

/// Create a copy of NotificationActor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? avatarUrl = freezed,}) {
  return _then(_NotificationActor(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NotificationModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'actor_id') String get actorId; NotificationActor? get actor; String get type;@JsonKey(name: 'target_id') String get targetId;@JsonKey(name: 'is_read') bool get isRead;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationModelCopyWith<NotificationModel> get copyWith => _$NotificationModelCopyWithImpl<NotificationModel>(this as NotificationModel, _$identity);

  /// Serializes this NotificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.type, type) || other.type == type)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,actorId,actor,type,targetId,isRead,createdAt);

@override
String toString() {
  return 'NotificationModel(id: $id, userId: $userId, actorId: $actorId, actor: $actor, type: $type, targetId: $targetId, isRead: $isRead, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $NotificationModelCopyWith<$Res>  {
  factory $NotificationModelCopyWith(NotificationModel value, $Res Function(NotificationModel) _then) = _$NotificationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'actor_id') String actorId, NotificationActor? actor, String type,@JsonKey(name: 'target_id') String targetId,@JsonKey(name: 'is_read') bool isRead,@JsonKey(name: 'created_at') DateTime? createdAt
});


$NotificationActorCopyWith<$Res>? get actor;

}
/// @nodoc
class _$NotificationModelCopyWithImpl<$Res>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._self, this._then);

  final NotificationModel _self;
  final $Res Function(NotificationModel) _then;

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? actorId = null,Object? actor = freezed,Object? type = null,Object? targetId = null,Object? isRead = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,actorId: null == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String,actor: freezed == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as NotificationActor?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationActorCopyWith<$Res>? get actor {
    if (_self.actor == null) {
    return null;
  }

  return $NotificationActorCopyWith<$Res>(_self.actor!, (value) {
    return _then(_self.copyWith(actor: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationModel].
extension NotificationModelPatterns on NotificationModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'actor_id')  String actorId,  NotificationActor? actor,  String type, @JsonKey(name: 'target_id')  String targetId, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
return $default(_that.id,_that.userId,_that.actorId,_that.actor,_that.type,_that.targetId,_that.isRead,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'actor_id')  String actorId,  NotificationActor? actor,  String type, @JsonKey(name: 'target_id')  String targetId, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _NotificationModel():
return $default(_that.id,_that.userId,_that.actorId,_that.actor,_that.type,_that.targetId,_that.isRead,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'actor_id')  String actorId,  NotificationActor? actor,  String type, @JsonKey(name: 'target_id')  String targetId, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
return $default(_that.id,_that.userId,_that.actorId,_that.actor,_that.type,_that.targetId,_that.isRead,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationModel implements NotificationModel {
  const _NotificationModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'actor_id') required this.actorId, this.actor, required this.type, @JsonKey(name: 'target_id') required this.targetId, @JsonKey(name: 'is_read') this.isRead = false, @JsonKey(name: 'created_at') this.createdAt});
  factory _NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'actor_id') final  String actorId;
@override final  NotificationActor? actor;
@override final  String type;
@override@JsonKey(name: 'target_id') final  String targetId;
@override@JsonKey(name: 'is_read') final  bool isRead;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationModelCopyWith<_NotificationModel> get copyWith => __$NotificationModelCopyWithImpl<_NotificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.type, type) || other.type == type)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,actorId,actor,type,targetId,isRead,createdAt);

@override
String toString() {
  return 'NotificationModel(id: $id, userId: $userId, actorId: $actorId, actor: $actor, type: $type, targetId: $targetId, isRead: $isRead, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationModelCopyWith<$Res> implements $NotificationModelCopyWith<$Res> {
  factory _$NotificationModelCopyWith(_NotificationModel value, $Res Function(_NotificationModel) _then) = __$NotificationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'actor_id') String actorId, NotificationActor? actor, String type,@JsonKey(name: 'target_id') String targetId,@JsonKey(name: 'is_read') bool isRead,@JsonKey(name: 'created_at') DateTime? createdAt
});


@override $NotificationActorCopyWith<$Res>? get actor;

}
/// @nodoc
class __$NotificationModelCopyWithImpl<$Res>
    implements _$NotificationModelCopyWith<$Res> {
  __$NotificationModelCopyWithImpl(this._self, this._then);

  final _NotificationModel _self;
  final $Res Function(_NotificationModel) _then;

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? actorId = null,Object? actor = freezed,Object? type = null,Object? targetId = null,Object? isRead = null,Object? createdAt = freezed,}) {
  return _then(_NotificationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,actorId: null == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String,actor: freezed == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as NotificationActor?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationActorCopyWith<$Res>? get actor {
    if (_self.actor == null) {
    return null;
  }

  return $NotificationActorCopyWith<$Res>(_self.actor!, (value) {
    return _then(_self.copyWith(actor: value));
  });
}
}

// dart format on
