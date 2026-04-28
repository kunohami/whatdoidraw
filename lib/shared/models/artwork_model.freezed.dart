// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artwork_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArtworkModel {

/// UUID único de la publicación del artwork.
 String get id;/// Referencia al autor de la obra.
@JsonKey(name: 'user_id') String get userId;/// Referencia opcional a la idea original del feed.
@JsonKey(name: 'idea_id') String? get ideaId;/// Referencia opcional al boceto (Doodle) que inspiró esta obra final.
@JsonKey(name: 'doodle_id') String? get doodleId;/// URL opcional de una miniatura o previsualización.
@JsonKey(name: 'preview_url') String? get previewUrl;/// Enlace obligatorio a la plataforma externa donde reside la obra original.
@JsonKey(name: 'external_link') String get externalLink;/// Etiquetas descriptivas.
 List<String> get tags;/// Estado de visibilidad de la publicación.
@JsonKey(name: 'is_active') bool get isActive;/// Fecha de publicación.
@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of ArtworkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArtworkModelCopyWith<ArtworkModel> get copyWith => _$ArtworkModelCopyWithImpl<ArtworkModel>(this as ArtworkModel, _$identity);

  /// Serializes this ArtworkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArtworkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.ideaId, ideaId) || other.ideaId == ideaId)&&(identical(other.doodleId, doodleId) || other.doodleId == doodleId)&&(identical(other.previewUrl, previewUrl) || other.previewUrl == previewUrl)&&(identical(other.externalLink, externalLink) || other.externalLink == externalLink)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,ideaId,doodleId,previewUrl,externalLink,const DeepCollectionEquality().hash(tags),isActive,createdAt);

@override
String toString() {
  return 'ArtworkModel(id: $id, userId: $userId, ideaId: $ideaId, doodleId: $doodleId, previewUrl: $previewUrl, externalLink: $externalLink, tags: $tags, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ArtworkModelCopyWith<$Res>  {
  factory $ArtworkModelCopyWith(ArtworkModel value, $Res Function(ArtworkModel) _then) = _$ArtworkModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'idea_id') String? ideaId,@JsonKey(name: 'doodle_id') String? doodleId,@JsonKey(name: 'preview_url') String? previewUrl,@JsonKey(name: 'external_link') String externalLink, List<String> tags,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$ArtworkModelCopyWithImpl<$Res>
    implements $ArtworkModelCopyWith<$Res> {
  _$ArtworkModelCopyWithImpl(this._self, this._then);

  final ArtworkModel _self;
  final $Res Function(ArtworkModel) _then;

/// Create a copy of ArtworkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? ideaId = freezed,Object? doodleId = freezed,Object? previewUrl = freezed,Object? externalLink = null,Object? tags = null,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ideaId: freezed == ideaId ? _self.ideaId : ideaId // ignore: cast_nullable_to_non_nullable
as String?,doodleId: freezed == doodleId ? _self.doodleId : doodleId // ignore: cast_nullable_to_non_nullable
as String?,previewUrl: freezed == previewUrl ? _self.previewUrl : previewUrl // ignore: cast_nullable_to_non_nullable
as String?,externalLink: null == externalLink ? _self.externalLink : externalLink // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArtworkModel].
extension ArtworkModelPatterns on ArtworkModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArtworkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArtworkModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArtworkModel value)  $default,){
final _that = this;
switch (_that) {
case _ArtworkModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArtworkModel value)?  $default,){
final _that = this;
switch (_that) {
case _ArtworkModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'idea_id')  String? ideaId, @JsonKey(name: 'doodle_id')  String? doodleId, @JsonKey(name: 'preview_url')  String? previewUrl, @JsonKey(name: 'external_link')  String externalLink,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArtworkModel() when $default != null:
return $default(_that.id,_that.userId,_that.ideaId,_that.doodleId,_that.previewUrl,_that.externalLink,_that.tags,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'idea_id')  String? ideaId, @JsonKey(name: 'doodle_id')  String? doodleId, @JsonKey(name: 'preview_url')  String? previewUrl, @JsonKey(name: 'external_link')  String externalLink,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ArtworkModel():
return $default(_that.id,_that.userId,_that.ideaId,_that.doodleId,_that.previewUrl,_that.externalLink,_that.tags,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'idea_id')  String? ideaId, @JsonKey(name: 'doodle_id')  String? doodleId, @JsonKey(name: 'preview_url')  String? previewUrl, @JsonKey(name: 'external_link')  String externalLink,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ArtworkModel() when $default != null:
return $default(_that.id,_that.userId,_that.ideaId,_that.doodleId,_that.previewUrl,_that.externalLink,_that.tags,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArtworkModel implements ArtworkModel {
  const _ArtworkModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'idea_id') this.ideaId, @JsonKey(name: 'doodle_id') this.doodleId, @JsonKey(name: 'preview_url') this.previewUrl, @JsonKey(name: 'external_link') required this.externalLink, final  List<String> tags = const [], @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'created_at') this.createdAt}): _tags = tags;
  factory _ArtworkModel.fromJson(Map<String, dynamic> json) => _$ArtworkModelFromJson(json);

/// UUID único de la publicación del artwork.
@override final  String id;
/// Referencia al autor de la obra.
@override@JsonKey(name: 'user_id') final  String userId;
/// Referencia opcional a la idea original del feed.
@override@JsonKey(name: 'idea_id') final  String? ideaId;
/// Referencia opcional al boceto (Doodle) que inspiró esta obra final.
@override@JsonKey(name: 'doodle_id') final  String? doodleId;
/// URL opcional de una miniatura o previsualización.
@override@JsonKey(name: 'preview_url') final  String? previewUrl;
/// Enlace obligatorio a la plataforma externa donde reside la obra original.
@override@JsonKey(name: 'external_link') final  String externalLink;
/// Etiquetas descriptivas.
 final  List<String> _tags;
/// Etiquetas descriptivas.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// Estado de visibilidad de la publicación.
@override@JsonKey(name: 'is_active') final  bool isActive;
/// Fecha de publicación.
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of ArtworkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArtworkModelCopyWith<_ArtworkModel> get copyWith => __$ArtworkModelCopyWithImpl<_ArtworkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArtworkModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArtworkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.ideaId, ideaId) || other.ideaId == ideaId)&&(identical(other.doodleId, doodleId) || other.doodleId == doodleId)&&(identical(other.previewUrl, previewUrl) || other.previewUrl == previewUrl)&&(identical(other.externalLink, externalLink) || other.externalLink == externalLink)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,ideaId,doodleId,previewUrl,externalLink,const DeepCollectionEquality().hash(_tags),isActive,createdAt);

@override
String toString() {
  return 'ArtworkModel(id: $id, userId: $userId, ideaId: $ideaId, doodleId: $doodleId, previewUrl: $previewUrl, externalLink: $externalLink, tags: $tags, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ArtworkModelCopyWith<$Res> implements $ArtworkModelCopyWith<$Res> {
  factory _$ArtworkModelCopyWith(_ArtworkModel value, $Res Function(_ArtworkModel) _then) = __$ArtworkModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'idea_id') String? ideaId,@JsonKey(name: 'doodle_id') String? doodleId,@JsonKey(name: 'preview_url') String? previewUrl,@JsonKey(name: 'external_link') String externalLink, List<String> tags,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$ArtworkModelCopyWithImpl<$Res>
    implements _$ArtworkModelCopyWith<$Res> {
  __$ArtworkModelCopyWithImpl(this._self, this._then);

  final _ArtworkModel _self;
  final $Res Function(_ArtworkModel) _then;

/// Create a copy of ArtworkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? ideaId = freezed,Object? doodleId = freezed,Object? previewUrl = freezed,Object? externalLink = null,Object? tags = null,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_ArtworkModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ideaId: freezed == ideaId ? _self.ideaId : ideaId // ignore: cast_nullable_to_non_nullable
as String?,doodleId: freezed == doodleId ? _self.doodleId : doodleId // ignore: cast_nullable_to_non_nullable
as String?,previewUrl: freezed == previewUrl ? _self.previewUrl : previewUrl // ignore: cast_nullable_to_non_nullable
as String?,externalLink: null == externalLink ? _self.externalLink : externalLink // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
