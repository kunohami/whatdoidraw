import 'package:freezed_annotation/freezed_annotation.dart';

part 'artwork_model.freezed.dart';
part 'artwork_model.g.dart';

/// Representa una obra de arte final externa vinculada al ecosistema.
///
/// El modelo de negocio de `whatdoidraw?` no almacena imágenes pesadas finales.
/// En su lugar, el [ArtworkModel] guarda un enlace externo a redes sociales
/// (Instagram, Behance, etc.) y lo vincula opcionalmente a un [doodleId]
/// para trazar la genealogía de la inspiración.
@freezed
abstract class ArtworkModel with _$ArtworkModel {
  const factory ArtworkModel({
    /// UUID único de la publicación del artwork.
    required String id,

    /// Referencia al autor de la obra.
    @JsonKey(name: 'user_id') required String userId,

    /// Nombre de usuario del autor (traído mediante JOIN en el Feed).
    String? authorName,

    /// Referencia opcional a la idea original del feed.
    @JsonKey(name: 'idea_id') String? ideaId,

    /// Referencia opcional al boceto (Doodle) que inspiró esta obra final.
    @JsonKey(name: 'doodle_id') String? doodleId,

    /// URL opcional de una miniatura o previsualización.
    @JsonKey(name: 'preview_url') String? previewUrl,

    /// Enlace obligatorio a la plataforma externa donde reside la obra original.
    @JsonKey(name: 'external_link') required String externalLink,

    /// Etiquetas descriptivas.
    @Default([]) List<String> tags,

    /// Estado de visibilidad de la publicación.
    @JsonKey(name: 'is_active') @Default(true) bool isActive,

    /// Fecha de publicación.
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ArtworkModel;

  factory ArtworkModel.fromJson(Map<String, dynamic> json) =>
      _$ArtworkModelFromJson(json);
}
