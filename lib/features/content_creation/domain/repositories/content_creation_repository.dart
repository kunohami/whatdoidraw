import '../../../../shared/models/stroke_model.dart';

// [DOC]: [LAYER: DOMAIN] 
// Esta interfaz dicta las capacidades de creación de nuestro sistema.
// Fíjate cómo no sabemos si el usuario o la idea son GUIDs de Firebase o Supabase, 
// solo exigimos un `String` básico en Dart para desacoplar.

abstract class IContentCreationRepository {
  Future<void> submitIdea(String content, String userId);
  Future<void> submitDoodle(List<StrokeModel> strokes, String userId, String? ideaId);
}
