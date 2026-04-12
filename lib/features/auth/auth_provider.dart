import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/providers/supabase_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<User?> build() async {
    final supabase = ref.watch(supabaseClientProvider);
    
    final session = supabase.auth.currentSession;
    if (session == null) {
      // No hay sesión, iniciar anónimo. Si falla, Riverpod atrapará la excepción.
      final response = await supabase.auth.signInAnonymously();
      if (response.user != null) {
        await _ensureUserExistsInPublicTable(response.user!.id);
      }
      return response.user;
    } else {
      // Ya hay sesión, garantizar que existe en la DB pública
      await _ensureUserExistsInPublicTable(session.user.id);
      return session.user;
    }
  }

  Future<void> _ensureUserExistsInPublicTable(String userId) async {
    final supabase = ref.read(supabaseClientProvider);
    try {
      final existingUser = await supabase
          .from('users')
          .select()
          .eq('id', userId)
          .maybeSingle();
      
      if (existingUser == null) {
        // Crear usuario "dummy" autogenerado basado en su ID anónimo
        await supabase.from('users').insert({
          'id': userId,
          'username': 'creator_${userId.substring(0, 6)}',
        });
      }
    } catch (e) {
      print('Error al asegurar perfil en tabla publica: $e');
    }
  }
}
