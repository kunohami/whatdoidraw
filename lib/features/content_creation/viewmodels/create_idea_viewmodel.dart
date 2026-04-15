import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../services/content_creation_service.dart';

part 'create_idea_viewmodel.g.dart';

// [DOC]: [LAYER: VIEWMODEL (MVVM) - STATE]
// Mantiene el estado de "Cargando". Interactúa directo con el Service.

@riverpod
class CreateIdeaController extends _$CreateIdeaController {
  @override
  bool build() {
    return false; // isLoading
  }

  Future<void> submitIdea(String content) async {
    state = true;
    try {
      final supabase = ref.read(supabaseClientProvider);
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) throw Exception('Inicia sesión para publicar ideas');

      await ref.read(contentCreationServiceProvider).insertIdea(content, userId);
      // En producción podrías usar un logger aquí.
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }
}
