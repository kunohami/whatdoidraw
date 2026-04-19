import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:whatdoidraw/features/feed/services/feed_service.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

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

/// Proveedor reactivo que expone el flujo constante de Doodles.
@riverpod
Stream<List<DoodleModel>> doodlesStream(Ref ref) {
  return ref.watch(feedServiceProvider).streamDoodles();
}
