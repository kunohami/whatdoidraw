import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../../../shared/models/idea_model.dart';

part 'feed_service.g.dart';

// [DOC]: [LAYER: SERVICE (MVVM)]
// Provee acceso directo a los datos del Feed.

@riverpod
FeedService feedService(Ref ref) {
  return FeedService(ref.watch(supabaseClientProvider));
}

class FeedService {
  final SupabaseClient supabaseClient;

  FeedService(this.supabaseClient);

  Stream<List<IdeaModel>> streamIdeas() {
    return supabaseClient
        .from('ideas')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((e) => IdeaModel.fromJson(e)).toList());
  }
}
