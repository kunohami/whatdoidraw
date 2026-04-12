import 'package:freezed_annotation/freezed_annotation.dart';

part 'stroke_model.freezed.dart';
part 'stroke_model.g.dart';

// [DOC]: Usamos clases concretas con Freezed en lugar de la clase nativa 'Offset' 
// del sistema porque queremos que nuestro modelo sea matemáticamente guardable en la Base de Datos (JSON).
// Un objeto 'Offset' en Flutter pinta puntos en la pantalla, pero no sabe convertirse a texto sin ayuda.

@freezed
abstract class PointModel with _$PointModel {
  const factory PointModel({
    required double x,
    required double y,
  }) = _PointModel;

  factory PointModel.fromJson(Map<String, dynamic> json) =>
      _$PointModelFromJson(json);
}

// [DOC]: StrokeModel (Trazo) representa toda una línea que se dibuja desde que 
// el usuario apoya el dedo hasta que lo levanta.
@freezed
abstract class StrokeModel with _$StrokeModel {
  const factory StrokeModel({
    required List<PointModel> points,
    @Default(0xFFFFFFFF) int colorValue, // Color base blanco/negro en Integer
    @Default(3.0) double strokeWidth,
  }) = _StrokeModel;

  factory StrokeModel.fromJson(Map<String, dynamic> json) =>
      _$StrokeModelFromJson(json);
}
