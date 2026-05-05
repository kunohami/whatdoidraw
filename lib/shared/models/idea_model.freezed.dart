// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'idea_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IdeaModel {

/// Identificador único universal (UUID) de la idea.
 String get id;/// ID del usuario que creó y publicó la idea originalmente.
@JsonKey(name: 'user_id') String get userId;/// El contenido textual de la idea (ej: "Un gato en Marte").
 String get content;/// Etiquetas opcionales para categorizar y buscar ideas.
 List<String> get tags;/// Indica si la idea sigue visible para la comunidad.
@JsonKey(name: 'is_active') bool get isActive;/// Idioma de la idea ('en' o 'es')
 String get language;/// Fecha y hora de creación de la publicación.
@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of IdeaModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IdeaModelCopyWith<IdeaModel> get copyWith => _$IdeaModelCopyWithImpl<IdeaModel>(this as IdeaModel, _$identity);

  /// Serializes this IdeaModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IdeaModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.language, language) || other.language == language)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,content,const DeepCollectionEquality().hash(tags),isActive,language,createdAt);

@override
String toString() {
  return 'IdeaModel(id: $id, userId: $userId, content: $content, tags: $tags, isActive: $isActive, language: $language, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $IdeaModelCopyWith<$Res>  {
  factory $IdeaModelCopyWith(IdeaModel value, $Res Function(IdeaModel) _then) = _$IdeaModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String content, List<String> tags,@JsonKey(name: 'is_active') bool isActive, String language,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$IdeaModelCopyWithImpl<$Res>
    implements $IdeaModelCopyWith<$Res> {
  _$IdeaModelCopyWithImpl(this._self, this._then);

  final IdeaModel _self;
  final $Res Function(IdeaModel) _then;

/// Create a copy of IdeaModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? content = null,Object? tags = null,Object? isActive = null,Object? language = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [IdeaModel].
extension IdeaModelPatterns on IdeaModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IdeaModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IdeaModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IdeaModel value)  $default,){
final _that = this;
switch (_that) {
case _IdeaModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IdeaModel value)?  $default,){
final _that = this;
switch (_that) {
case _IdeaModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String content,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive,  String language, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IdeaModel() when $default != null:
return $default(_that.id,_that.userId,_that.content,_that.tags,_that.isActive,_that.language,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String content,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive,  String language, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _IdeaModel():
return $default(_that.id,_that.userId,_that.content,_that.tags,_that.isActive,_that.language,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String content,  List<String> tags, @JsonKey(name: 'is_active')  bool isActive,  String language, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _IdeaModel() when $default != null:
return $default(_that.id,_that.userId,_that.content,_that.tags,_that.isActive,_that.language,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IdeaModel implements IdeaModel {
  const _IdeaModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.content, final  List<String> tags = const [], @JsonKey(name: 'is_active') this.isActive = true, this.language = 'en', @JsonKey(name: 'created_at') this.createdAt}): _tags = tags;
  factory _IdeaModel.fromJson(Map<String, dynamic> json) => _$IdeaModelFromJson(json);

/// Identificador único universal (UUID) de la idea.
@override final  String id;
/// ID del usuario que creó y publicó la idea originalmente.
@override@JsonKey(name: 'user_id') final  String userId;
/// El contenido textual de la idea (ej: "Un gato en Marte").
@override final  String content;
/// Etiquetas opcionales para categorizar y buscar ideas.
 final  List<String> _tags;
/// Etiquetas opcionales para categorizar y buscar ideas.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// Indica si la idea sigue visible para la comunidad.
@override@JsonKey(name: 'is_active') final  bool isActive;
/// Idioma de la idea ('en' o 'es')
@override@JsonKey() final  String language;
/// Fecha y hora de creación de la publicación.
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of IdeaModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IdeaModelCopyWith<_IdeaModel> get copyWith => __$IdeaModelCopyWithImpl<_IdeaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IdeaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IdeaModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.language, language) || other.language == language)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,content,const DeepCollectionEquality().hash(_tags),isActive,language,createdAt);

@override
String toString() {
  return 'IdeaModel(id: $id, userId: $userId, content: $content, tags: $tags, isActive: $isActive, language: $language, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$IdeaModelCopyWith<$Res> implements $IdeaModelCopyWith<$Res> {
  factory _$IdeaModelCopyWith(_IdeaModel value, $Res Function(_IdeaModel) _then) = __$IdeaModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String content, List<String> tags,@JsonKey(name: 'is_active') bool isActive, String language,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$IdeaModelCopyWithImpl<$Res>
    implements _$IdeaModelCopyWith<$Res> {
  __$IdeaModelCopyWithImpl(this._self, this._then);

  final _IdeaModel _self;
  final $Res Function(_IdeaModel) _then;

/// Create a copy of IdeaModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? content = null,Object? tags = null,Object? isActive = null,Object? language = null,Object? createdAt = freezed,}) {
  return _then(_IdeaModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
