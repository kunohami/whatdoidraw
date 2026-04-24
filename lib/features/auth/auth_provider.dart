import 'dart:async'; // Para unawaited
import 'package:flutter/foundation.dart'; // Para kIsWeb
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/core/providers/supabase_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  bool _isGoogleInitialized = false;
  GoogleSignIn? _googleSignIn;

  // Permite inyectar un mock en tests
  @visibleForTesting
  set googleSignIn(GoogleSignIn value) => _googleSignIn = value;

  GoogleSignIn get _googleInstance => _googleSignIn ?? GoogleSignIn.instance;

  @override
  FutureOr<User?> build() async {
    final supabase = ref.watch(supabaseClientProvider);

    // Inicialización proactiva para Web
    if (kIsWeb && !_isGoogleInitialized) {
      unawaited(_initializeGoogle());
    }

    final session = supabase.auth.currentSession;
    return session?.user;
  }

  Future<void> _initializeGoogle() async {
    if (_isGoogleInitialized) return;

    const webClientId =
        '451289377302-u6a4t3g12hdr6aj0obb3eefv2tqfrur9.apps.googleusercontent.com';

    await _googleInstance.initialize(
      clientId: kIsWeb ? webClientId : null,
      serverClientId: kIsWeb ? null : webClientId,
    );
    _isGoogleInitialized = true;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    final supabase = ref.read(supabaseClientProvider);

    try {
      if (!_isGoogleInitialized) {
        await _initializeGoogle();
      }

      final googleSignIn = _googleInstance;

      // En v7.x authenticate() devuelve el usuario.
      // Si el usuario cancela, suele lanzar una excepción o podemos capturarlo.
      final googleUser = await googleSignIn.authenticate();

      // El getter 'authentication' ahora es síncrono y solo contiene el idToken
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'No se pudo obtener el ID Token de Google';
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      if (response.user != null) {
        // Aseguramos perfil en tabla pública usando el nombre de Google si no existe
        await _ensureUserExistsInPublicTable(
          response.user!.id,
          response.user!.userMetadata?['full_name'] ?? 'Google User',
        );
      }

      state = AsyncData(response.user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
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
      // Usamos upsert para no fallar si ya existe
      await supabase.from('users').upsert({
        'id': userId,
        'username': username,
      }, onConflict: 'id');
    } catch (e) {
      // Error silencioso en perfil público.
    }
  }
}
