import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/models/idea_model.dart';
import '../services/feed_service.dart';

part 'feed_viewmodel.g.dart';

/// Proveedor reactivo que expone el flujo de ideas para la interfaz de usuario.
/// 
/// Este ViewModel actúa como un puente entre la UI y el [FeedService].
/// Al usar un `StreamProvider`, la UI se redibujará automáticamente
/// cada vez que el servicio emita una nueva lista de ideas desde Supabase.
@riverpod
Stream<List<IdeaModel>> ideasStream(Ref ref) {
  // Observamos el servicio para reaccionar si este cambia.
  return ref.watch(feedServiceProvider).streamIdeas();
}
