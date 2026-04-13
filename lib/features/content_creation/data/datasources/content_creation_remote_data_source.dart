import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../shared/models/stroke_model.dart';

// [DOC]: [LAYER: DATA]
// Inserciones directas al servicio BaaS remoto.

abstract class IContentCreationRemoteDataSource {
  Future<void> insertIdea(String content, String userId);
  Future<void> insertDoodle(List<Map<String, dynamic>> doodleData, String userId, String? ideaId);
}

class ContentCreationRemoteDataSourceImpl implements IContentCreationRemoteDataSource {
  final SupabaseClient supabaseClient;

  ContentCreationRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> insertIdea(String content, String userId) async {
    await supabaseClient.from('ideas').insert({
      'content': content,
      'user_id': userId,
    });
  }

  @override
  Future<void> insertDoodle(List<Map<String, dynamic>> doodleData, String userId, String? ideaId) async {
    await supabaseClient.from('doodles').insert({
      'user_id': userId,
      'idea_id': ideaId,
      'doodle_data': doodleData, // Se enviará como JSONB nativamente
    });
  }
}
