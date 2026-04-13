import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/supabase_provider.dart';
import 'content_creation_di.dart';

part 'create_idea_provider.g.dart';

// [DOC]: [LAYER: PRESENTATION - STATE]
// Mantiene el estado de "Cargando". Interactúa mediante Clean Architecture con Domain.

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

      await ref.read(submitIdeaUseCaseProvider).call(
        content: content,
        userId: userId,
      );
    } catch (e) {
      print('Error posting idea: $e');
      rethrow;
    } finally {
      state = false;
    }
  }
}
