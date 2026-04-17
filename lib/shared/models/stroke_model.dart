import 'package:freezed_annotation/freezed_annotation.dart';

part 'stroke_model.freezed.dart';
part 'stroke_model.g.dart';

/// Representa una coordenada matemática simple (X, Y) dentro del lienzo.
/// 
/// A diferencia del tipo `Offset` nativo de Flutter, esta clase es compatible
/// con la generación de código para JSON, lo que permite que las coordenadas 
/// del dibujo puedan ser persistidas en una base de datos externa como Supabase.
@freezed
abstract class PointModel with _$PointModel {
  const factory PointModel({
    /// La posición horizontal desde el borde izquierdo del lienzo.
    required double x,
    /// La posición vertical desde el borde superior del lienzo.
    required double y,
  }) = _PointModel;

  factory PointModel.fromJson(Map<String, dynamic> json) =>
      _$PointModelFromJson(json);
}

/// Define un trazo continuo dibujado por el usuario en pantalla.
/// 
/// Un trazo se compone de una serie de puntos ([PointModel]) conectados entre sí,
/// además de las propiedades visuales que definen cómo debe renderizarse
/// por el motor gráfico.
@freezed
abstract class StrokeModel with _$StrokeModel {
  const factory StrokeModel({
    /// Lista ordenada de puntos que componen el recorrido del trazo.
    required List<PointModel> points,
    
    /// Valor entero que representa el color en formato ARGB (ej: 0xFFFFFFFF para blanco).
    @Default(0xFFFFFFFF) int colorValue,
    
    /// El grosor de la línea en píxeles lógicos.
    @Default(3.0) double strokeWidth,
  }) = _StrokeModel;

  factory StrokeModel.fromJson(Map<String, dynamic> json) =>
      _$StrokeModelFromJson(json);
}
