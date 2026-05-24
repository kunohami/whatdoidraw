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
 List<StrokeModel> get strokes;/// Etiquetas que el usuario ha asignado al doodle antes de publicarlo.
 List<String> get tags;/// Indica si se está realizando una operación asíncrona (como subir a la nube).
 bool get isSubmitting;/// Almacena un mensaje de error descriptivo si algo falla.
 String? get errorMessage;/// Herramienta de dibujo actualmente seleccionada.
 DrawingTool get activeTool;/// Color activo del pincel en formato ARGB.
 int get brushColor;/// Grosor activo de la línea/pincel.
 double get strokeWidth;/// Color de fondo del lienzo en formato ARGB.
 int get backgroundColor;/// Historial de estados anteriores de trazos para la función deshacer.
 List<List<StrokeModel>> get undoHistory;
/// Create a copy of DoodleCanvasState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoodleCanvasStateCopyWith<DoodleCanvasState> get copyWith => _$DoodleCanvasStateCopyWithImpl<DoodleCanvasState>(this as DoodleCanvasState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoodleCanvasState&&const DeepCollectionEquality().equals(other.strokes, strokes)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.activeTool, activeTool) || other.activeTool == activeTool)&&(identical(other.brushColor, brushColor) || other.brushColor == brushColor)&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&const DeepCollectionEquality().equals(other.undoHistory, undoHistory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(strokes),const DeepCollectionEquality().hash(tags),isSubmitting,errorMessage,activeTool,brushColor,strokeWidth,backgroundColor,const DeepCollectionEquality().hash(undoHistory));

@override
String toString() {
  return 'DoodleCanvasState(strokes: $strokes, tags: $tags, isSubmitting: $isSubmitting, errorMessage: $errorMessage, activeTool: $activeTool, brushColor: $brushColor, strokeWidth: $strokeWidth, backgroundColor: $backgroundColor, undoHistory: $undoHistory)';
}


}

/// @nodoc
abstract mixin class $DoodleCanvasStateCopyWith<$Res>  {
  factory $DoodleCanvasStateCopyWith(DoodleCanvasState value, $Res Function(DoodleCanvasState) _then) = _$DoodleCanvasStateCopyWithImpl;
@useResult
$Res call({
 List<StrokeModel> strokes, List<String> tags, bool isSubmitting, String? errorMessage, DrawingTool activeTool, int brushColor, double strokeWidth, int backgroundColor, List<List<StrokeModel>> undoHistory
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
@pragma('vm:prefer-inline') @override $Res call({Object? strokes = null,Object? tags = null,Object? isSubmitting = null,Object? errorMessage = freezed,Object? activeTool = null,Object? brushColor = null,Object? strokeWidth = null,Object? backgroundColor = null,Object? undoHistory = null,}) {
  return _then(_self.copyWith(
strokes: null == strokes ? _self.strokes : strokes // ignore: cast_nullable_to_non_nullable
as List<StrokeModel>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,activeTool: null == activeTool ? _self.activeTool : activeTool // ignore: cast_nullable_to_non_nullable
as DrawingTool,brushColor: null == brushColor ? _self.brushColor : brushColor // ignore: cast_nullable_to_non_nullable
as int,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as int,undoHistory: null == undoHistory ? _self.undoHistory : undoHistory // ignore: cast_nullable_to_non_nullable
as List<List<StrokeModel>>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StrokeModel> strokes,  List<String> tags,  bool isSubmitting,  String? errorMessage,  DrawingTool activeTool,  int brushColor,  double strokeWidth,  int backgroundColor,  List<List<StrokeModel>> undoHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoodleCanvasState() when $default != null:
return $default(_that.strokes,_that.tags,_that.isSubmitting,_that.errorMessage,_that.activeTool,_that.brushColor,_that.strokeWidth,_that.backgroundColor,_that.undoHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StrokeModel> strokes,  List<String> tags,  bool isSubmitting,  String? errorMessage,  DrawingTool activeTool,  int brushColor,  double strokeWidth,  int backgroundColor,  List<List<StrokeModel>> undoHistory)  $default,) {final _that = this;
switch (_that) {
case _DoodleCanvasState():
return $default(_that.strokes,_that.tags,_that.isSubmitting,_that.errorMessage,_that.activeTool,_that.brushColor,_that.strokeWidth,_that.backgroundColor,_that.undoHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StrokeModel> strokes,  List<String> tags,  bool isSubmitting,  String? errorMessage,  DrawingTool activeTool,  int brushColor,  double strokeWidth,  int backgroundColor,  List<List<StrokeModel>> undoHistory)?  $default,) {final _that = this;
switch (_that) {
case _DoodleCanvasState() when $default != null:
return $default(_that.strokes,_that.tags,_that.isSubmitting,_that.errorMessage,_that.activeTool,_that.brushColor,_that.strokeWidth,_that.backgroundColor,_that.undoHistory);case _:
  return null;

}
}

}

/// @nodoc


class _DoodleCanvasState implements DoodleCanvasState {
  const _DoodleCanvasState({final  List<StrokeModel> strokes = const [], final  List<String> tags = const [], this.isSubmitting = false, this.errorMessage, this.activeTool = DrawingTool.pen, this.brushColor = 0xFFE53935, this.strokeWidth = 4.0, this.backgroundColor = 0xFFFFFFFF, final  List<List<StrokeModel>> undoHistory = const []}): _strokes = strokes,_tags = tags,_undoHistory = undoHistory;
  

/// Lista de trazos vectoriales dibujados actualmente.
 final  List<StrokeModel> _strokes;
/// Lista de trazos vectoriales dibujados actualmente.
@override@JsonKey() List<StrokeModel> get strokes {
  if (_strokes is EqualUnmodifiableListView) return _strokes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strokes);
}

/// Etiquetas que el usuario ha asignado al doodle antes de publicarlo.
 final  List<String> _tags;
/// Etiquetas que el usuario ha asignado al doodle antes de publicarlo.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// Indica si se está realizando una operación asíncrona (como subir a la nube).
@override@JsonKey() final  bool isSubmitting;
/// Almacena un mensaje de error descriptivo si algo falla.
@override final  String? errorMessage;
/// Herramienta de dibujo actualmente seleccionada.
@override@JsonKey() final  DrawingTool activeTool;
/// Color activo del pincel en formato ARGB.
@override@JsonKey() final  int brushColor;
/// Grosor activo de la línea/pincel.
@override@JsonKey() final  double strokeWidth;
/// Color de fondo del lienzo en formato ARGB.
@override@JsonKey() final  int backgroundColor;
/// Historial de estados anteriores de trazos para la función deshacer.
 final  List<List<StrokeModel>> _undoHistory;
/// Historial de estados anteriores de trazos para la función deshacer.
@override@JsonKey() List<List<StrokeModel>> get undoHistory {
  if (_undoHistory is EqualUnmodifiableListView) return _undoHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_undoHistory);
}


/// Create a copy of DoodleCanvasState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoodleCanvasStateCopyWith<_DoodleCanvasState> get copyWith => __$DoodleCanvasStateCopyWithImpl<_DoodleCanvasState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoodleCanvasState&&const DeepCollectionEquality().equals(other._strokes, _strokes)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.activeTool, activeTool) || other.activeTool == activeTool)&&(identical(other.brushColor, brushColor) || other.brushColor == brushColor)&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&const DeepCollectionEquality().equals(other._undoHistory, _undoHistory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_strokes),const DeepCollectionEquality().hash(_tags),isSubmitting,errorMessage,activeTool,brushColor,strokeWidth,backgroundColor,const DeepCollectionEquality().hash(_undoHistory));

@override
String toString() {
  return 'DoodleCanvasState(strokes: $strokes, tags: $tags, isSubmitting: $isSubmitting, errorMessage: $errorMessage, activeTool: $activeTool, brushColor: $brushColor, strokeWidth: $strokeWidth, backgroundColor: $backgroundColor, undoHistory: $undoHistory)';
}


}

/// @nodoc
abstract mixin class _$DoodleCanvasStateCopyWith<$Res> implements $DoodleCanvasStateCopyWith<$Res> {
  factory _$DoodleCanvasStateCopyWith(_DoodleCanvasState value, $Res Function(_DoodleCanvasState) _then) = __$DoodleCanvasStateCopyWithImpl;
@override @useResult
$Res call({
 List<StrokeModel> strokes, List<String> tags, bool isSubmitting, String? errorMessage, DrawingTool activeTool, int brushColor, double strokeWidth, int backgroundColor, List<List<StrokeModel>> undoHistory
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
@override @pragma('vm:prefer-inline') $Res call({Object? strokes = null,Object? tags = null,Object? isSubmitting = null,Object? errorMessage = freezed,Object? activeTool = null,Object? brushColor = null,Object? strokeWidth = null,Object? backgroundColor = null,Object? undoHistory = null,}) {
  return _then(_DoodleCanvasState(
strokes: null == strokes ? _self._strokes : strokes // ignore: cast_nullable_to_non_nullable
as List<StrokeModel>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,activeTool: null == activeTool ? _self.activeTool : activeTool // ignore: cast_nullable_to_non_nullable
as DrawingTool,brushColor: null == brushColor ? _self.brushColor : brushColor // ignore: cast_nullable_to_non_nullable
as int,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as int,undoHistory: null == undoHistory ? _self._undoHistory : undoHistory // ignore: cast_nullable_to_non_nullable
as List<List<StrokeModel>>,
  ));
}


}

// dart format on
