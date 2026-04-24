import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:whatdoidraw/core/providers/supabase_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<User?> build() async {
    final supabase = ref.watch(supabaseClientProvider);

    final session = supabase.auth.currentSession;
    return session?.user;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    state = const AsyncLoading();
    final supabase = ref.read(supabaseClientProvider);

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      if (response.user != null) {
        await _ensureUserExistsInPublicTable(response.user!.id, username);
        state = AsyncData(response.user);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    final supabase = ref.read(supabaseClientProvider);

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      state = AsyncData(response.user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    final supabase = ref.read(supabaseClientProvider);
    await supabase.auth.signOut();
    state = const AsyncData(null);
  }

  Future<void> _ensureUserExistsInPublicTable(
    String userId,
    String username,
  ) async {
    final supabase = ref.read(supabaseClientProvider);
    try {
      await supabase.from('users').upsert({'id': userId, 'username': username});
    } catch (e) {
      // Error silencioso en perfil público.
    }
  }
}
