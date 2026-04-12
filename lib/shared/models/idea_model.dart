import 'package:freezed_annotation/freezed_annotation.dart';

part 'idea_model.freezed.dart';
part 'idea_model.g.dart';

@freezed
abstract class IdeaModel with _$IdeaModel {
  const factory IdeaModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String content,
    @Default([]) List<String> tags,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _IdeaModel;

  factory IdeaModel.fromJson(Map<String, dynamic> json) =>
      _$IdeaModelFromJson(json);
}
