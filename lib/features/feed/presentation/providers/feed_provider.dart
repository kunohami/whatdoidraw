import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../domain/entities/idea_model.dart';

import '../../data/datasources/feed_remote_data_source.dart';
import '../../data/repositories/feed_repository_impl.dart';
import '../../domain/repositories/feed_repository.dart';
import '../../domain/usecases/get_ideas_stream_usecase.dart';

part 'feed_provider.g.dart';

// [DOC]: [LAYER: PRESENTATION - DEPENDENCY INJECTION]
// Riverpod nos provee los conectores (wiring) para estructurar el árbol de Clean Architecture.

@riverpod
IFeedRemoteDataSource feedRemoteDataSource(Ref ref) {
  return FeedRemoteDataSourceImpl(ref.watch(supabaseClientProvider));
}

@riverpod
IFeedRepository feedRepository(Ref ref) {
  return FeedRepositoryImpl(ref.watch(feedRemoteDataSourceProvider));
}

@riverpod
GetIdeasStreamUseCase getIdeasStreamUseCase(Ref ref) {
  return GetIdeasStreamUseCase(ref.watch(feedRepositoryProvider));
}

// [DOC]: [LAYER: PRESENTATION - STATE]
// La UI pide el stream, pero el Provider jamás invoca a Supabase, 
// invoca a su UseCase puramente lógico.

@riverpod
Stream<List<IdeaModel>> ideasStream(Ref ref) {
  return ref.watch(getIdeasStreamUseCaseProvider).call();
}
