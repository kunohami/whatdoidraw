import '../repositories/content_creation_repository.dart';

// [DOC]: [LAYER: DOMAIN]
// Caso de uso. Su única misión de vida es publicar Ideas de texto.
// Mantiene el código extremadamente modular.

class SubmitIdeaUseCase {
  final IContentCreationRepository _repository;

  SubmitIdeaUseCase(this._repository);

  Future<void> call({required String content, required String userId}) async {
    // Si tuviéramos lógicas de negocio intensas (ej: Censura de lenguaje inapropiado),
    // se ejecutarían justo AQUÍ antes de llamar al repositorio.
    if (content.trim().isEmpty) throw Exception('El contenido no puede estar vacío');
    
    await _repository.submitIdea(content.trim(), userId);
  }
}
