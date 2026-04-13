import '../../../../shared/models/stroke_model.dart';
import '../repositories/content_creation_repository.dart';

// [DOC]: [LAYER: DOMAIN]
// Caso de uso para emitir arte. Solo toma las variables abstractas y las orquesta.

class SubmitDoodleUseCase {
  final IContentCreationRepository _repository;

  SubmitDoodleUseCase(this._repository);

  Future<void> call({
    required List<StrokeModel> strokes, 
    required String userId, 
    String? ideaId,
  }) async {
    if (strokes.isEmpty) throw Exception('No se puede enviar un lienzo vacío');
    
    await _repository.submitDoodle(strokes, userId, ideaId);
  }
}
