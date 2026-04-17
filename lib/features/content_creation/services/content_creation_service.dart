import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:whatdoidraw/core/providers/supabase_provider.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';

part 'content_creation_service.g.dart';

/// Servicio responsable de persistir las creaciones de los usuarios en la nube.
/// 
/// Gestiona tanto la publicación de prompts de texto (Ideas) como la subida
/// de datos vectoriales complejos (Doodles).
@riverpod
ContentCreationService contentCreationService(Ref ref) {
  return ContentCreationService(ref.watch(supabaseClientProvider));
}

class ContentCreationService {
  /// Instancia del cliente de Supabase para operaciones de base de datos.
  final SupabaseClient supabaseClient;

  ContentCreationService(this.supabaseClient);

  /// Registra una nueva idea textual en la base de datos.
  /// 
  /// Recibe el [content] (texto) y el [userId] del autor.
  Future<void> insertIdea(String content, String userId) async {
    await supabaseClient.from('ideas').insert({
      'content': content,
      'user_id': userId,
    });
  }

  /// Registra un dibujo (Doodle) en formato vectorial.
  /// 
  /// Transforma la lista de [strokes] (trazos) en un objeto JSON compatible 
  /// con el campo JSONB de PostgreSQL. Opcionalmente se puede vincular a 
  /// un [ideaId] si el dibujo fue inspirado por una idea del feed.
  Future<void> insertDoodle(List<StrokeModel> strokes, String userId, String? ideaId) async {
    // Transformación: Cada StrokeModel sabe convertirse a Map gracias a freezed.
    final doodleData = strokes.map((s) => s.toJson()).toList();
    
    await supabaseClient.from('doodles').insert({
      'user_id': userId,
      'idea_id': ideaId,
      'doodle_data': doodleData,
    });
  }
}
