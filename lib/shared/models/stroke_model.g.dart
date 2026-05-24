// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PointModel _$PointModelFromJson(Map<String, dynamic> json) => _PointModel(
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
);

Map<String, dynamic> _$PointModelToJson(_PointModel instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};

_StrokeModel _$StrokeModelFromJson(Map<String, dynamic> json) => _StrokeModel(
  points: (json['points'] as List<dynamic>)
      .map((e) => PointModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  colorValue: (json['colorValue'] as num?)?.toInt() ?? 0xFFFFFFFF,
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 3.0,
  isColorLayer: json['isColorLayer'] as bool? ?? false,
);

Map<String, dynamic> _$StrokeModelToJson(_StrokeModel instance) =>
    <String, dynamic>{
      'points': instance.points,
      'colorValue': instance.colorValue,
      'strokeWidth': instance.strokeWidth,
      'isColorLayer': instance.isColorLayer,
    };
