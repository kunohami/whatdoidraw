import '../entities/idea_model.dart';
import '../repositories/feed_repository.dart';

// [DOC]: [LAYER: DOMAIN] 
// Los UseCases encapsulan UNA y SOLO UNA acción del negocio dictada por el Project Manager.
// La Interfaz de Usuario (UI) se comunica exclusivamente con este UseCase para pedir cosas.

class GetIdeasStreamUseCase {
  final IFeedRepository repository;
  
  GetIdeasStreamUseCase(this.repository);

  Stream<List<IdeaModel>> call() {
    return repository.watchIdeas();
  }
}
