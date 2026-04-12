import 'package:freezed_annotation/freezed_annotation.dart';

part 'doodle_model.freezed.dart';
part 'doodle_model.g.dart';

@freezed
abstract class DoodleModel with _$DoodleModel {
  const factory DoodleModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'idea_id') String? ideaId,
    @JsonKey(name: 'doodle_data') required Map<String, dynamic> doodleData,
    @Default([]) List<String> tags,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _DoodleModel;

  factory DoodleModel.fromJson(Map<String, dynamic> json) =>
      _$DoodleModelFromJson(json);
}
