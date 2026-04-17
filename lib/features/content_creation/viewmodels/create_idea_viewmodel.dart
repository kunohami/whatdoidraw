import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../services/content_creation_service.dart';

part 'create_idea_viewmodel.g.dart';

/// Controlador encargado de gestionar el estado de creación de una nueva idea.
/// 
/// Mantiene un estado booleano simple que indica si el proceso de subida
/// (publicación) está en curso para mostrar indicadores de carga en la UI.
@riverpod
class CreateIdeaController extends _$CreateIdeaController {
  @override
  bool build() {
    // El estado inicial es 'false' (no está cargando).
    return false;
  }

  /// Ejecuta la lógica para publicar una idea con el [content] proporcionado.
  /// 
  /// 1. Cambia el estado a `true` (activando el spinner en la View).
  /// 2. Valida la sesión del usuario.
  /// 3. Llama al servicio de persistencia.
  /// 4. Maneja posibles errores asíncronos.
  Future<void> submitIdea(String content) async {
    state = true;
    try {
      final supabase = ref.read(supabaseClientProvider);
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) throw Exception('Inicia sesión para publicar ideas');

      await ref.read(contentCreationServiceProvider).insertIdea(content, userId);
    } catch (e) {
      // Nota: En una app comercial aquí loggeríamos el error a Sentry/Crashlytics.
      rethrow;
    } finally {
      // Garantizamos que el estado de carga se desactive pase lo que pase.
      state = false;
    }
  }
}
