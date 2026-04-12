import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/supabase_provider.dart';
import '../auth/auth_provider.dart';

part 'create_idea_provider.g.dart';

@riverpod
class CreateIdeaController extends _$CreateIdeaController {
  @override
  bool build() {
    return false; // represents loading state
  }

  Future<void> submitIdea(String content) async {
    state = true; // loading is true
    
    try {
      final supabase = ref.read(supabaseClientProvider);
      final user = await ref.read(authControllerProvider.future);
      
      if (user == null) {
        throw Exception('No estás autenticado.');
      }

      await supabase.from('ideas').insert({
        'user_id': user.id,
        'content': content,
      });
    } catch (e) {
      print('Error posting idea: \$e');
      rethrow;
    } finally {
      state = false;
    }
  }
}
