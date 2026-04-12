import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/supabase_provider.dart';
import '../../shared/models/idea_model.dart';

part 'feed_provider.g.dart';

@riverpod
Stream<List<IdeaModel>> ideasStream(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return supabase
      .from('ideas')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: false)
      .map((data) => data.map((e) => IdeaModel.fromJson(e)).toList());
}
