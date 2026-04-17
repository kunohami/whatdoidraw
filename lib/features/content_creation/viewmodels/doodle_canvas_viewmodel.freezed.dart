// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doodle_canvas_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoodleCanvasState {

/// Lista de trazos vectoriales dibujados actualmente.
 List<StrokeModel> get strokes;/// Indica si se está realizando una operación asíncrona (como subir a la nube).
 bool get isSubmitting;/// Almacena un mensaje de error descriptivo si algo falla.
 String? get errorMessage;
/// Create a copy of DoodleCanvasState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoodleCanvasStateCopyWith<DoodleCanvasState> get copyWith => _$DoodleCanvasStateCopyWithImpl<DoodleCanvasState>(this as DoodleCanvasState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoodleCanvasState&&const DeepCollectionEquality().equals(other.strokes, strokes)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(strokes),isSubmitting,errorMessage);

@override
String toString() {
  return 'DoodleCanvasState(strokes: $strokes, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DoodleCanvasStateCopyWith<$Res>  {
  factory $DoodleCanvasStateCopyWith(DoodleCanvasState value, $Res Function(DoodleCanvasState) _then) = _$DoodleCanvasStateCopyWithImpl;
@useResult
$Res call({
 List<StrokeModel> strokes, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class _$DoodleCanvasStateCopyWithImpl<$Res>
    implements $DoodleCanvasStateCopyWith<$Res> {
  _$DoodleCanvasStateCopyWithImpl(this._self, this._then);

  final DoodleCanvasState _self;
  final $Res Function(DoodleCanvasState) _then;

/// Create a copy of DoodleCanvasState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? strokes = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
strokes: null == strokes ? _self.strokes : strokes // ignore: cast_nullable_to_non_nullable
as List<StrokeModel>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DoodleCanvasState].
extension DoodleCanvasStatePatterns on DoodleCanvasState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoodleCanvasState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoodleCanvasState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoodleCanvasState value)  $default,){
final _that = this;
switch (_that) {
case _DoodleCanvasState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoodleCanvasState value)?  $default,){
final _that = this;
switch (_that) {
case _DoodleCanvasState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StrokeModel> strokes,  bool isSubmitting,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoodleCanvasState() when $default != null:
return $default(_that.strokes,_that.isSubmitting,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StrokeModel> strokes,  bool isSubmitting,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DoodleCanvasState():
return $default(_that.strokes,_that.isSubmitting,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StrokeModel> strokes,  bool isSubmitting,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DoodleCanvasState() when $default != null:
return $default(_that.strokes,_that.isSubmitting,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DoodleCanvasState implements DoodleCanvasState {
  const _DoodleCanvasState({final  List<StrokeModel> strokes = const [], this.isSubmitting = false, this.errorMessage}): _strokes = strokes;
  

/// Lista de trazos vectoriales dibujados actualmente.
 final  List<StrokeModel> _strokes;
/// Lista de trazos vectoriales dibujados actualmente.
@override@JsonKey() List<StrokeModel> get strokes {
  if (_strokes is EqualUnmodifiableListView) return _strokes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strokes);
}

/// Indica si se está realizando una operación asíncrona (como subir a la nube).
@override@JsonKey() final  bool isSubmitting;
/// Almacena un mensaje de error descriptivo si algo falla.
@override final  String? errorMessage;

/// Create a copy of DoodleCanvasState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoodleCanvasStateCopyWith<_DoodleCanvasState> get copyWith => __$DoodleCanvasStateCopyWithImpl<_DoodleCanvasState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoodleCanvasState&&const DeepCollectionEquality().equals(other._strokes, _strokes)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_strokes),isSubmitting,errorMessage);

@override
String toString() {
  return 'DoodleCanvasState(strokes: $strokes, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DoodleCanvasStateCopyWith<$Res> implements $DoodleCanvasStateCopyWith<$Res> {
  factory _$DoodleCanvasStateCopyWith(_DoodleCanvasState value, $Res Function(_DoodleCanvasState) _then) = __$DoodleCanvasStateCopyWithImpl;
@override @useResult
$Res call({
 List<StrokeModel> strokes, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class __$DoodleCanvasStateCopyWithImpl<$Res>
    implements _$DoodleCanvasStateCopyWith<$Res> {
  __$DoodleCanvasStateCopyWithImpl(this._self, this._then);

  final _DoodleCanvasState _self;
  final $Res Function(_DoodleCanvasState) _then;

/// Create a copy of DoodleCanvasState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strokes = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(_DoodleCanvasState(
strokes: null == strokes ? _self._strokes : strokes // ignore: cast_nullable_to_non_nullable
as List<StrokeModel>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
