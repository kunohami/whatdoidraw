// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doodle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoodleModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'idea_id') String? get ideaId;@JsonKey(name: 'doodle_data') dynamic get doodleData; List<String> get tags;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'likes_count') int get likesCount; bool get isLiked;/// Nombre de usuario del autor (traído mediante JOIN en el Feed).
 String? get authorName;
/// Create a copy of DoodleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoodleModelCopyWith<DoodleModel> get copyWith => _$DoodleModelCopyWithImpl<DoodleModel>(this as DoodleModel, _$identity);

  /// Serializes this DoodleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoodleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.ideaId, ideaId) || other.ideaId == ideaId)&&const DeepCollectionEquality().equals(other.doodleData, doodleData)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.authorName, authorName) || other.authorName == authorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,ideaId,const DeepCollectionEquality().hash(doodleData),const DeepCollectionEquality().hash(tags),isActive,createdAt,likesCount,isLiked,authorName);

@override
String toString() {
  return 'DoodleModel(id: $id, userId: $userId, ideaId: $ideaId, doodleData: $doodleData, tags: $tags, isActive: $isActive, createdAt: $createdAt, likesCount: $likesCount, isLiked: $isLiked, authorName: $authorName)';
}


}

/// @nodoc
abstract mixin class $DoodleModelCopyWith<$Res>  {
  factory $DoodleModelCopyWith(DoodleModel value, $Res Function(DoodleModel) _then) = _$DoodleModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'idea_id') String? ideaId,@JsonKey(name: 'doodle_data') dynamic doodleData, List<String> tags,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'likes_count') int likesCount, bool isLiked, String? authorName
});




}
/// @nodoc
class _$DoodleModelCopyWithImpl<$Res>
    implements $DoodleModelCopyWith<$Res> {
  _$DoodleModelCopyWithImpl(this._self, this._then);

  final DoodleModel _self;
  final $Res Function(DoodleModel) _then;

/// Create a copy of DoodleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? ideaId = freezed,Object? doodleData = freezed,Object? tags = null,Object? isActive = null,Object? createdAt = freezed,Object? likesCount = null,Object? isLiked = null,Object? authorName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ideaId: freezed == ideaId ? _self.ideaId : ideaId // ignore: cast_nullable_to_non_nullable
as String?,doodleData: freezed == doodleData ? _self.doodleData : doodleData // ignore: cast_nullable_to_non_nullable
as dynamic,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DoodleModel].
extension DoodleModelPatterns on DoodleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoodleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoodleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoodleModel value)  $default,){
final _that = this;
switch (_that) {
case _DoodleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoodleModel value)?  $default,){
final _that = this;
switch (_that) {
case _DoodleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'idea_id')  String? ideaId, @JsonKey(name: 'doodle_data')  dynamic doodleData,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'likes_count')  int likesCount,  bool isLiked,  String? authorName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoodleModel() when $default != null:
return $default(_that.id,_that.userId,_that.ideaId,_that.doodleData,_that.tags,_that.isActive,_that.createdAt,_that.likesCount,_that.isLiked,_that.authorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'idea_id')  String? ideaId, @JsonKey(name: 'doodle_data')  dynamic doodleData,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'likes_count')  int likesCount,  bool isLiked,  String? authorName)  $default,) {final _that = this;
switch (_that) {
case _DoodleModel():
return $default(_that.id,_that.userId,_that.ideaId,_that.doodleData,_that.tags,_that.isActive,_that.createdAt,_that.likesCount,_that.isLiked,_that.authorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'idea_id')  String? ideaId, @JsonKey(name: 'doodle_data')  dynamic doodleData,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'likes_count')  int likesCount,  bool isLiked,  String? authorName)?  $default,) {final _that = this;
switch (_that) {
case _DoodleModel() when $default != null:
return $default(_that.id,_that.userId,_that.ideaId,_that.doodleData,_that.tags,_that.isActive,_that.createdAt,_that.likesCount,_that.isLiked,_that.authorName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoodleModel implements DoodleModel {
  const _DoodleModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'idea_id') this.ideaId, @JsonKey(name: 'doodle_data') required this.doodleData, final  List<String> tags = const [], @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'likes_count') this.likesCount = 0, this.isLiked = false, this.authorName}): _tags = tags;
  factory _DoodleModel.fromJson(Map<String, dynamic> json) => _$DoodleModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'idea_id') final  String? ideaId;
@override@JsonKey(name: 'doodle_data') final  dynamic doodleData;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'likes_count') final  int likesCount;
@override@JsonKey() final  bool isLiked;
/// Nombre de usuario del autor (traído mediante JOIN en el Feed).
@override final  String? authorName;

/// Create a copy of DoodleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoodleModelCopyWith<_DoodleModel> get copyWith => __$DoodleModelCopyWithImpl<_DoodleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoodleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoodleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.ideaId, ideaId) || other.ideaId == ideaId)&&const DeepCollectionEquality().equals(other.doodleData, doodleData)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.authorName, authorName) || other.authorName == authorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,ideaId,const DeepCollectionEquality().hash(doodleData),const DeepCollectionEquality().hash(_tags),isActive,createdAt,likesCount,isLiked,authorName);

@override
String toString() {
  return 'DoodleModel(id: $id, userId: $userId, ideaId: $ideaId, doodleData: $doodleData, tags: $tags, isActive: $isActive, createdAt: $createdAt, likesCount: $likesCount, isLiked: $isLiked, authorName: $authorName)';
}


}

/// @nodoc
abstract mixin class _$DoodleModelCopyWith<$Res> implements $DoodleModelCopyWith<$Res> {
  factory _$DoodleModelCopyWith(_DoodleModel value, $Res Function(_DoodleModel) _then) = __$DoodleModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'idea_id') String? ideaId,@JsonKey(name: 'doodle_data') dynamic doodleData, List<String> tags,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'likes_count') int likesCount, bool isLiked, String? authorName
});




}
/// @nodoc
class __$DoodleModelCopyWithImpl<$Res>
    implements _$DoodleModelCopyWith<$Res> {
  __$DoodleModelCopyWithImpl(this._self, this._then);

  final _DoodleModel _self;
  final $Res Function(_DoodleModel) _then;

/// Create a copy of DoodleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? ideaId = freezed,Object? doodleData = freezed,Object? tags = null,Object? isActive = null,Object? createdAt = freezed,Object? likesCount = null,Object? isLiked = null,Object? authorName = freezed,}) {
  return _then(_DoodleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ideaId: freezed == ideaId ? _self.ideaId : ideaId // ignore: cast_nullable_to_non_nullable
as String?,doodleData: freezed == doodleData ? _self.doodleData : doodleData // ignore: cast_nullable_to_non_nullable
as dynamic,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
