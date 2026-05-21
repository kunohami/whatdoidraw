import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Representa el perfil público de un usuario en el sistema.
///
/// Contiene la información básica de identidad y preferencias del creador.
/// Al usar la anotación `@freezed`, este modelo es inmutable por naturaleza,
/// lo que previene errores accidentales en la modificación de datos del usuario.
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    /// Identificador único vinculado al sistema de autenticación (Supabase Auth).
    required String id,

    /// Nombre visible del usuario elegido al registrarse.
    required String username,

    /// Enlace a la imagen de perfil alojada en el storage.
    @JsonKey(name: 'avatar_url') String? avatarUrl,

    /// Indica si el usuario ha sido verificado como artista profesional.
    @JsonKey(name: 'is_artist') @Default(false) bool isArtist,

    /// Enlace personal a la web o redes del artista.
    @JsonKey(name: 'portfolio_url') String? portfolioUrl,

    /// Un mensaje corto o biografía del usuario.
    @JsonKey(name: 'short_message') String? shortMessage,

    /// Fecha en la que el usuario se unió a la comunidad.
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
