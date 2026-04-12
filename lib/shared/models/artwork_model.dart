import 'package:freezed_annotation/freezed_annotation.dart';

part 'artwork_model.freezed.dart';
part 'artwork_model.g.dart';

@freezed
abstract class ArtworkModel with _$ArtworkModel {
  const factory ArtworkModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'doodle_id') String? doodleId,
    @JsonKey(name: 'preview_url') String? previewUrl,
    @JsonKey(name: 'external_link') required String externalLink,
    @Default([]) List<String> tags,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ArtworkModel;

  factory ArtworkModel.fromJson(Map<String, dynamic> json) =>
      _$ArtworkModelFromJson(json);
}
