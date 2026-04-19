import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:whatdoidraw/core/providers/supabase_provider.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';

part 'feed_service.g.dart';

/// Servicio encargado de la recuperación de datos para el muro de ideas (Feed).
///
/// En la arquitectura MVVM, los Servicios se encargan de la comunicación
/// directa con fuentes externas (BaaS, APIs) y transforman los datos crudos
/// en modelos de objetos útiles para la aplicación.
@riverpod
FeedService feedService(Ref ref) {
  return FeedService(ref.watch(supabaseClientProvider));
}

class FeedService {
  /// Cliente de Supabase inyectado para realizar peticiones.
  final SupabaseClient supabaseClient;

  FeedService(this.supabaseClient);

  /// Obtiene un flujo de datos (Stream) en tiempo real de las ideas publicadas.
  ///
  /// Al usar `.stream()`, la aplicación reaccionará automáticamente a nuevos
  /// insertos o actualizaciones en la tabla de la base de datos sin necesidad
  /// de recargar la pantalla manualmente.
  ///
  /// Retorna una lista de objetos [IdeaModel] ordenados por fecha de creación.
  Stream<List<IdeaModel>> streamIdeas() {
    return supabaseClient
        .from('ideas')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((e) => IdeaModel.fromJson(e)).toList());
  }

  /// Obtiene un flujo en tiempo real de todos los Doodles públicos.
  /// 
  /// Ordena los dibujos publicados globalmente por fecha, para
  /// mostrarlos en la pestaña de exploración.
  Stream<List<DoodleModel>> streamDoodles() {
    return supabaseClient
        .from('doodles')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((e) => DoodleModel.fromJson(e)).toList());
  }
}
