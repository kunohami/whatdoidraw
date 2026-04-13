import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/idea_model.dart';

// [DOC]: [LAYER: DATA] 
// El Data Source hace el trabajo sucio. Conoce SDKs externos (SupabaseClient).
// Las inyecciones y excepciones de red nacen y mueren aquí.

abstract class IFeedRemoteDataSource {
  Stream<List<IdeaModel>> streamIdeas();
}

class FeedRemoteDataSourceImpl implements IFeedRemoteDataSource {
  final SupabaseClient supabaseClient;

  FeedRemoteDataSourceImpl(this.supabaseClient);

  @override
  Stream<List<IdeaModel>> streamIdeas() {
    try {
      return supabaseClient
          .from('ideas')
          .stream(primaryKey: ['id'])
          .order('created_at', ascending: false)
          .map((data) => data.map((e) => IdeaModel.fromJson(e)).toList());
    } catch (e) {
      // Aquí se podrían hacer transformaciones de NetworkException Custom
      rethrow;
    }
  }
}
