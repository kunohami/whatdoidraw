// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

/// Identificador único vinculado al sistema de autenticación (Supabase Auth).
 String get id;/// Nombre visible del usuario elegido al registrarse.
 String get username;/// Enlace a la imagen de perfil alojada en el storage.
@JsonKey(name: 'avatar_url') String? get avatarUrl;/// Indica si el usuario ha sido verificado como artista profesional.
@JsonKey(name: 'is_artist') bool get isArtist;/// Enlace personal a la web o redes del artista.
@JsonKey(name: 'portfolio_url') String? get portfolioUrl;/// Un mensaje corto o biografía del usuario.
@JsonKey(name: 'short_message') String? get shortMessage;/// Fecha en la que el usuario actualizó su nombre de usuario por última vez.
@JsonKey(name: 'username_updated_at') DateTime? get usernameUpdatedAt;/// Fecha en la que el usuario se unió a la comunidad.
@JsonKey(name: 'created_at') DateTime? get createdAt;/// Preferencia: Recibir notificaciones por correo.
@JsonKey(name: 'email_notifications') bool get emailNotifications;/// Preferencia: Recibir notificaciones en el dispositivo móvil.
@JsonKey(name: 'push_notifications') bool get pushNotifications;/// Flag: Si ya se le preguntó al usuario sobre los permisos push.
@JsonKey(name: 'has_seen_push_prompt') bool get hasSeenPushPrompt;/// Token FCM para notificaciones push.
@JsonKey(name: 'fcm_token') String? get fcmToken;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isArtist, isArtist) || other.isArtist == isArtist)&&(identical(other.portfolioUrl, portfolioUrl) || other.portfolioUrl == portfolioUrl)&&(identical(other.shortMessage, shortMessage) || other.shortMessage == shortMessage)&&(identical(other.usernameUpdatedAt, usernameUpdatedAt) || other.usernameUpdatedAt == usernameUpdatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.hasSeenPushPrompt, hasSeenPushPrompt) || other.hasSeenPushPrompt == hasSeenPushPrompt)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,avatarUrl,isArtist,portfolioUrl,shortMessage,usernameUpdatedAt,createdAt,emailNotifications,pushNotifications,hasSeenPushPrompt,fcmToken);

@override
String toString() {
  return 'UserModel(id: $id, username: $username, avatarUrl: $avatarUrl, isArtist: $isArtist, portfolioUrl: $portfolioUrl, shortMessage: $shortMessage, usernameUpdatedAt: $usernameUpdatedAt, createdAt: $createdAt, emailNotifications: $emailNotifications, pushNotifications: $pushNotifications, hasSeenPushPrompt: $hasSeenPushPrompt, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String username,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'is_artist') bool isArtist,@JsonKey(name: 'portfolio_url') String? portfolioUrl,@JsonKey(name: 'short_message') String? shortMessage,@JsonKey(name: 'username_updated_at') DateTime? usernameUpdatedAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'email_notifications') bool emailNotifications,@JsonKey(name: 'push_notifications') bool pushNotifications,@JsonKey(name: 'has_seen_push_prompt') bool hasSeenPushPrompt,@JsonKey(name: 'fcm_token') String? fcmToken
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? avatarUrl = freezed,Object? isArtist = null,Object? portfolioUrl = freezed,Object? shortMessage = freezed,Object? usernameUpdatedAt = freezed,Object? createdAt = freezed,Object? emailNotifications = null,Object? pushNotifications = null,Object? hasSeenPushPrompt = null,Object? fcmToken = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isArtist: null == isArtist ? _self.isArtist : isArtist // ignore: cast_nullable_to_non_nullable
as bool,portfolioUrl: freezed == portfolioUrl ? _self.portfolioUrl : portfolioUrl // ignore: cast_nullable_to_non_nullable
as String?,shortMessage: freezed == shortMessage ? _self.shortMessage : shortMessage // ignore: cast_nullable_to_non_nullable
as String?,usernameUpdatedAt: freezed == usernameUpdatedAt ? _self.usernameUpdatedAt : usernameUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,emailNotifications: null == emailNotifications ? _self.emailNotifications : emailNotifications // ignore: cast_nullable_to_non_nullable
as bool,pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,hasSeenPushPrompt: null == hasSeenPushPrompt ? _self.hasSeenPushPrompt : hasSeenPushPrompt // ignore: cast_nullable_to_non_nullable
as bool,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_artist')  bool isArtist, @JsonKey(name: 'portfolio_url')  String? portfolioUrl, @JsonKey(name: 'short_message')  String? shortMessage, @JsonKey(name: 'username_updated_at')  DateTime? usernameUpdatedAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'email_notifications')  bool emailNotifications, @JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'has_seen_push_prompt')  bool hasSeenPushPrompt, @JsonKey(name: 'fcm_token')  String? fcmToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.username,_that.avatarUrl,_that.isArtist,_that.portfolioUrl,_that.shortMessage,_that.usernameUpdatedAt,_that.createdAt,_that.emailNotifications,_that.pushNotifications,_that.hasSeenPushPrompt,_that.fcmToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_artist')  bool isArtist, @JsonKey(name: 'portfolio_url')  String? portfolioUrl, @JsonKey(name: 'short_message')  String? shortMessage, @JsonKey(name: 'username_updated_at')  DateTime? usernameUpdatedAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'email_notifications')  bool emailNotifications, @JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'has_seen_push_prompt')  bool hasSeenPushPrompt, @JsonKey(name: 'fcm_token')  String? fcmToken)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.username,_that.avatarUrl,_that.isArtist,_that.portfolioUrl,_that.shortMessage,_that.usernameUpdatedAt,_that.createdAt,_that.emailNotifications,_that.pushNotifications,_that.hasSeenPushPrompt,_that.fcmToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_artist')  bool isArtist, @JsonKey(name: 'portfolio_url')  String? portfolioUrl, @JsonKey(name: 'short_message')  String? shortMessage, @JsonKey(name: 'username_updated_at')  DateTime? usernameUpdatedAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'email_notifications')  bool emailNotifications, @JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'has_seen_push_prompt')  bool hasSeenPushPrompt, @JsonKey(name: 'fcm_token')  String? fcmToken)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.username,_that.avatarUrl,_that.isArtist,_that.portfolioUrl,_that.shortMessage,_that.usernameUpdatedAt,_that.createdAt,_that.emailNotifications,_that.pushNotifications,_that.hasSeenPushPrompt,_that.fcmToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.username, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'is_artist') this.isArtist = false, @JsonKey(name: 'portfolio_url') this.portfolioUrl, @JsonKey(name: 'short_message') this.shortMessage, @JsonKey(name: 'username_updated_at') this.usernameUpdatedAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'email_notifications') this.emailNotifications = false, @JsonKey(name: 'push_notifications') this.pushNotifications = false, @JsonKey(name: 'has_seen_push_prompt') this.hasSeenPushPrompt = false, @JsonKey(name: 'fcm_token') this.fcmToken});
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

/// Identificador único vinculado al sistema de autenticación (Supabase Auth).
@override final  String id;
/// Nombre visible del usuario elegido al registrarse.
@override final  String username;
/// Enlace a la imagen de perfil alojada en el storage.
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
/// Indica si el usuario ha sido verificado como artista profesional.
@override@JsonKey(name: 'is_artist') final  bool isArtist;
/// Enlace personal a la web o redes del artista.
@override@JsonKey(name: 'portfolio_url') final  String? portfolioUrl;
/// Un mensaje corto o biografía del usuario.
@override@JsonKey(name: 'short_message') final  String? shortMessage;
/// Fecha en la que el usuario actualizó su nombre de usuario por última vez.
@override@JsonKey(name: 'username_updated_at') final  DateTime? usernameUpdatedAt;
/// Fecha en la que el usuario se unió a la comunidad.
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
/// Preferencia: Recibir notificaciones por correo.
@override@JsonKey(name: 'email_notifications') final  bool emailNotifications;
/// Preferencia: Recibir notificaciones en el dispositivo móvil.
@override@JsonKey(name: 'push_notifications') final  bool pushNotifications;
/// Flag: Si ya se le preguntó al usuario sobre los permisos push.
@override@JsonKey(name: 'has_seen_push_prompt') final  bool hasSeenPushPrompt;
/// Token FCM para notificaciones push.
@override@JsonKey(name: 'fcm_token') final  String? fcmToken;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isArtist, isArtist) || other.isArtist == isArtist)&&(identical(other.portfolioUrl, portfolioUrl) || other.portfolioUrl == portfolioUrl)&&(identical(other.shortMessage, shortMessage) || other.shortMessage == shortMessage)&&(identical(other.usernameUpdatedAt, usernameUpdatedAt) || other.usernameUpdatedAt == usernameUpdatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.hasSeenPushPrompt, hasSeenPushPrompt) || other.hasSeenPushPrompt == hasSeenPushPrompt)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,avatarUrl,isArtist,portfolioUrl,shortMessage,usernameUpdatedAt,createdAt,emailNotifications,pushNotifications,hasSeenPushPrompt,fcmToken);

@override
String toString() {
  return 'UserModel(id: $id, username: $username, avatarUrl: $avatarUrl, isArtist: $isArtist, portfolioUrl: $portfolioUrl, shortMessage: $shortMessage, usernameUpdatedAt: $usernameUpdatedAt, createdAt: $createdAt, emailNotifications: $emailNotifications, pushNotifications: $pushNotifications, hasSeenPushPrompt: $hasSeenPushPrompt, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String username,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'is_artist') bool isArtist,@JsonKey(name: 'portfolio_url') String? portfolioUrl,@JsonKey(name: 'short_message') String? shortMessage,@JsonKey(name: 'username_updated_at') DateTime? usernameUpdatedAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'email_notifications') bool emailNotifications,@JsonKey(name: 'push_notifications') bool pushNotifications,@JsonKey(name: 'has_seen_push_prompt') bool hasSeenPushPrompt,@JsonKey(name: 'fcm_token') String? fcmToken
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? avatarUrl = freezed,Object? isArtist = null,Object? portfolioUrl = freezed,Object? shortMessage = freezed,Object? usernameUpdatedAt = freezed,Object? createdAt = freezed,Object? emailNotifications = null,Object? pushNotifications = null,Object? hasSeenPushPrompt = null,Object? fcmToken = freezed,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isArtist: null == isArtist ? _self.isArtist : isArtist // ignore: cast_nullable_to_non_nullable
as bool,portfolioUrl: freezed == portfolioUrl ? _self.portfolioUrl : portfolioUrl // ignore: cast_nullable_to_non_nullable
as String?,shortMessage: freezed == shortMessage ? _self.shortMessage : shortMessage // ignore: cast_nullable_to_non_nullable
as String?,usernameUpdatedAt: freezed == usernameUpdatedAt ? _self.usernameUpdatedAt : usernameUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,emailNotifications: null == emailNotifications ? _self.emailNotifications : emailNotifications // ignore: cast_nullable_to_non_nullable
as bool,pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,hasSeenPushPrompt: null == hasSeenPushPrompt ? _self.hasSeenPushPrompt : hasSeenPushPrompt // ignore: cast_nullable_to_non_nullable
as bool,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
