import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/models/idea_model.dart';
import '../services/feed_service.dart';

part 'feed_viewmodel.g.dart';

// [DOC]: [LAYER: VIEWMODEL (MVVM)]
// Provee el stream de ideas directamente desde el servicio.

@riverpod
Stream<List<IdeaModel>> ideasStream(Ref ref) {
  return ref.watch(feedServiceProvider).streamIdeas();
}
