import 'package:freezed_annotation/freezed_annotation.dart';

part 'idea_model.freezed.dart';
part 'idea_model.g.dart';

/// Representa una "Idea" o prompt de texto publicado por un usuario.
/// 
/// Las ideas son la semilla del ecosistema de `whatdoidraw?`. Sirven como
/// disparadores creativos para que otros usuarios creen dibujos (Doodles)
/// inspirados en el contenido de texto.
@freezed
abstract class IdeaModel with _$IdeaModel {
  const factory IdeaModel({
    /// Identificador único universal (UUID) de la idea.
    required String id,
    
    /// ID del usuario que creó y publicó la idea originalmente.
    @JsonKey(name: 'user_id') required String userId,
    
    /// El contenido textual de la idea (ej: "Un gato en Marte").
    required String content,
    
    /// Etiquetas opcionales para categorizar y buscar ideas.
    @Default([]) List<String> tags,
    
    /// Indica si la idea sigue visible para la comunidad.
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    
    /// Fecha y hora de creación de la publicación.
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _IdeaModel;

  factory IdeaModel.fromJson(Map<String, dynamic> json) =>
      _$IdeaModelFromJson(json);
}
