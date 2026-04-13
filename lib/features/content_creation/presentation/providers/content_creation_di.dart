import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/supabase_provider.dart';

import '../../data/datasources/content_creation_remote_data_source.dart';
import '../../data/repositories/content_creation_repository_impl.dart';
import '../../domain/repositories/content_creation_repository.dart';
import '../../domain/usecases/submit_idea_usecase.dart';
import '../../domain/usecases/submit_doodle_usecase.dart';

part 'content_creation_di.g.dart';

// [DOC]: [LAYER: PRESENTATION - DEPENDENCY INJECTION]
// Agrupamos la entrega de Casos de Uso (DI Container).

@riverpod
IContentCreationRemoteDataSource contentCreationRemoteDataSource(Ref ref) {
  return ContentCreationRemoteDataSourceImpl(ref.watch(supabaseClientProvider));
}

@riverpod
IContentCreationRepository contentCreationRepository(Ref ref) {
  return ContentCreationRepositoryImpl(ref.watch(contentCreationRemoteDataSourceProvider));
}

@riverpod
SubmitIdeaUseCase submitIdeaUseCase(Ref ref) {
  return SubmitIdeaUseCase(ref.watch(contentCreationRepositoryProvider));
}

@riverpod
SubmitDoodleUseCase submitDoodleUseCase(Ref ref) {
  return SubmitDoodleUseCase(ref.watch(contentCreationRepositoryProvider));
}
