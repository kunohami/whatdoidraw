// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stroke_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PointModel {

/// La posición horizontal desde el borde izquierdo del lienzo.
 double get x;/// La posición vertical desde el borde superior del lienzo.
 double get y;
/// Create a copy of PointModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointModelCopyWith<PointModel> get copyWith => _$PointModelCopyWithImpl<PointModel>(this as PointModel, _$identity);

  /// Serializes this PointModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointModel&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'PointModel(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $PointModelCopyWith<$Res>  {
  factory $PointModelCopyWith(PointModel value, $Res Function(PointModel) _then) = _$PointModelCopyWithImpl;
@useResult
$Res call({
 double x, double y
});




}
/// @nodoc
class _$PointModelCopyWithImpl<$Res>
    implements $PointModelCopyWith<$Res> {
  _$PointModelCopyWithImpl(this._self, this._then);

  final PointModel _self;
  final $Res Function(PointModel) _then;

/// Create a copy of PointModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PointModel].
extension PointModelPatterns on PointModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointModel value)  $default,){
final _that = this;
switch (_that) {
case _PointModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointModel value)?  $default,){
final _that = this;
switch (_that) {
case _PointModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double x,  double y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointModel() when $default != null:
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double x,  double y)  $default,) {final _that = this;
switch (_that) {
case _PointModel():
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double x,  double y)?  $default,) {final _that = this;
switch (_that) {
case _PointModel() when $default != null:
return $default(_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointModel implements PointModel {
  const _PointModel({required this.x, required this.y});
  factory _PointModel.fromJson(Map<String, dynamic> json) => _$PointModelFromJson(json);

/// La posición horizontal desde el borde izquierdo del lienzo.
@override final  double x;
/// La posición vertical desde el borde superior del lienzo.
@override final  double y;

/// Create a copy of PointModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointModelCopyWith<_PointModel> get copyWith => __$PointModelCopyWithImpl<_PointModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointModel&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'PointModel(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$PointModelCopyWith<$Res> implements $PointModelCopyWith<$Res> {
  factory _$PointModelCopyWith(_PointModel value, $Res Function(_PointModel) _then) = __$PointModelCopyWithImpl;
@override @useResult
$Res call({
 double x, double y
});




}
/// @nodoc
class __$PointModelCopyWithImpl<$Res>
    implements _$PointModelCopyWith<$Res> {
  __$PointModelCopyWithImpl(this._self, this._then);

  final _PointModel _self;
  final $Res Function(_PointModel) _then;

/// Create a copy of PointModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,}) {
  return _then(_PointModel(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$StrokeModel {

/// Lista ordenada de puntos que componen el recorrido del trazo.
 List<PointModel> get points;/// Valor entero que representa el color en formato ARGB (ej: 0xFFFFFFFF para blanco).
 int get colorValue;/// El grosor de la línea en píxeles lógicos.
 double get strokeWidth;/// Indica si pertenece a la capa de color (se renderiza debajo de las líneas negras).
 bool get isColorLayer;
/// Create a copy of StrokeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrokeModelCopyWith<StrokeModel> get copyWith => _$StrokeModelCopyWithImpl<StrokeModel>(this as StrokeModel, _$identity);

  /// Serializes this StrokeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrokeModel&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.colorValue, colorValue) || other.colorValue == colorValue)&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth)&&(identical(other.isColorLayer, isColorLayer) || other.isColorLayer == isColorLayer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(points),colorValue,strokeWidth,isColorLayer);

@override
String toString() {
  return 'StrokeModel(points: $points, colorValue: $colorValue, strokeWidth: $strokeWidth, isColorLayer: $isColorLayer)';
}


}

/// @nodoc
abstract mixin class $StrokeModelCopyWith<$Res>  {
  factory $StrokeModelCopyWith(StrokeModel value, $Res Function(StrokeModel) _then) = _$StrokeModelCopyWithImpl;
@useResult
$Res call({
 List<PointModel> points, int colorValue, double strokeWidth, bool isColorLayer
});




}
/// @nodoc
class _$StrokeModelCopyWithImpl<$Res>
    implements $StrokeModelCopyWith<$Res> {
  _$StrokeModelCopyWithImpl(this._self, this._then);

  final StrokeModel _self;
  final $Res Function(StrokeModel) _then;

/// Create a copy of StrokeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? colorValue = null,Object? strokeWidth = null,Object? isColorLayer = null,}) {
  return _then(_self.copyWith(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<PointModel>,colorValue: null == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,isColorLayer: null == isColorLayer ? _self.isColorLayer : isColorLayer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StrokeModel].
extension StrokeModelPatterns on StrokeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StrokeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StrokeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StrokeModel value)  $default,){
final _that = this;
switch (_that) {
case _StrokeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StrokeModel value)?  $default,){
final _that = this;
switch (_that) {
case _StrokeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PointModel> points,  int colorValue,  double strokeWidth,  bool isColorLayer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StrokeModel() when $default != null:
return $default(_that.points,_that.colorValue,_that.strokeWidth,_that.isColorLayer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PointModel> points,  int colorValue,  double strokeWidth,  bool isColorLayer)  $default,) {final _that = this;
switch (_that) {
case _StrokeModel():
return $default(_that.points,_that.colorValue,_that.strokeWidth,_that.isColorLayer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PointModel> points,  int colorValue,  double strokeWidth,  bool isColorLayer)?  $default,) {final _that = this;
switch (_that) {
case _StrokeModel() when $default != null:
return $default(_that.points,_that.colorValue,_that.strokeWidth,_that.isColorLayer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StrokeModel implements StrokeModel {
  const _StrokeModel({required final  List<PointModel> points, this.colorValue = 0xFFFFFFFF, this.strokeWidth = 3.0, this.isColorLayer = false}): _points = points;
  factory _StrokeModel.fromJson(Map<String, dynamic> json) => _$StrokeModelFromJson(json);

/// Lista ordenada de puntos que componen el recorrido del trazo.
 final  List<PointModel> _points;
/// Lista ordenada de puntos que componen el recorrido del trazo.
@override List<PointModel> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

/// Valor entero que representa el color en formato ARGB (ej: 0xFFFFFFFF para blanco).
@override@JsonKey() final  int colorValue;
/// El grosor de la línea en píxeles lógicos.
@override@JsonKey() final  double strokeWidth;
/// Indica si pertenece a la capa de color (se renderiza debajo de las líneas negras).
@override@JsonKey() final  bool isColorLayer;

/// Create a copy of StrokeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StrokeModelCopyWith<_StrokeModel> get copyWith => __$StrokeModelCopyWithImpl<_StrokeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StrokeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StrokeModel&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.colorValue, colorValue) || other.colorValue == colorValue)&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth)&&(identical(other.isColorLayer, isColorLayer) || other.isColorLayer == isColorLayer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_points),colorValue,strokeWidth,isColorLayer);

@override
String toString() {
  return 'StrokeModel(points: $points, colorValue: $colorValue, strokeWidth: $strokeWidth, isColorLayer: $isColorLayer)';
}


}

/// @nodoc
abstract mixin class _$StrokeModelCopyWith<$Res> implements $StrokeModelCopyWith<$Res> {
  factory _$StrokeModelCopyWith(_StrokeModel value, $Res Function(_StrokeModel) _then) = __$StrokeModelCopyWithImpl;
@override @useResult
$Res call({
 List<PointModel> points, int colorValue, double strokeWidth, bool isColorLayer
});




}
/// @nodoc
class __$StrokeModelCopyWithImpl<$Res>
    implements _$StrokeModelCopyWith<$Res> {
  __$StrokeModelCopyWithImpl(this._self, this._then);

  final _StrokeModel _self;
  final $Res Function(_StrokeModel) _then;

/// Create a copy of StrokeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? colorValue = null,Object? strokeWidth = null,Object? isColorLayer = null,}) {
  return _then(_StrokeModel(
points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<PointModel>,colorValue: null == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,isColorLayer: null == isColorLayer ? _self.isColorLayer : isColorLayer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
