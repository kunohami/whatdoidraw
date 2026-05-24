import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';

part 'doodle_model.freezed.dart';
part 'doodle_model.g.dart';

@freezed
abstract class DoodleModel with _$DoodleModel {
  const factory DoodleModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'idea_id') String? ideaId,
    @JsonKey(name: 'doodle_data') required dynamic doodleData,
    @Default([]) List<String> tags,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'likes_count') @Default(0) int likesCount,
    @Default(false) bool isLiked,

    /// Nombre de usuario del autor (traído mediante JOIN en el Feed).
    String? authorName,
  }) = _DoodleModel;

  factory DoodleModel.fromJson(Map<String, dynamic> json) =>
      _$DoodleModelFromJson(json);
}

extension DoodleModelX on DoodleModel {
  List<StrokeModel> get strokes {
    if (doodleData is List) {
      return (doodleData as List)
          .map((e) => StrokeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (doodleData is Map) {
      final strokesList = doodleData['strokes'] as List? ?? [];
      return strokesList
          .map((e) => StrokeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  int get backgroundColorValue {
    if (doodleData is Map && doodleData.containsKey('backgroundColor')) {
      return doodleData['backgroundColor'] as int;
    }
    return 0xFFFFFFFF; // Default white background
  }
}
