import '../entities/idea_model.dart';

// [DOC]: [LAYER: DOMAIN] 
// La capa de Dominio define QUÉ hace la aplicación resolviendo las necesidades del negocio. 
// Aquí declaramos el contrato abstracto. Esta capa es la más pura, no le importa si usamos Supabase, Firebase o un JSON local.
abstract class IFeedRepository {
  Stream<List<IdeaModel>> watchIdeas();
}
