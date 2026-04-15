import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../shared/models/stroke_model.dart';
import '../../../../core/providers/supabase_provider.dart';

part 'content_creation_service.g.dart';

// [DOC]: [LAYER: SERVICE (MVVM)]
// Inserciones directas al servicio remoto. Actúa como el único intermediario de red.

@riverpod
ContentCreationService contentCreationService(Ref ref) {
  return ContentCreationService(ref.watch(supabaseClientProvider));
}

class ContentCreationService {
  final SupabaseClient supabaseClient;

  ContentCreationService(this.supabaseClient);

  Future<void> insertIdea(String content, String userId) async {
    await supabaseClient.from('ideas').insert({
      'content': content,
      'user_id': userId,
    });
  }

  Future<void> insertDoodle(List<StrokeModel> strokes, String userId, String? ideaId) async {
    final doodleData = strokes.map((s) => s.toJson()).toList();
    await supabaseClient.from('doodles').insert({
      'user_id': userId,
      'idea_id': ideaId,
      'doodle_data': doodleData,
    });
  }
}
