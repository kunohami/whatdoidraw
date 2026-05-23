import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/core/providers/locale_provider.dart';
import 'package:whatdoidraw/core/providers/supabase_provider.dart';
import 'package:whatdoidraw/main.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class FakeGoTrueClient extends Fake implements GoTrueClient {
  @override
  User? get currentUser => null;

  @override
  Stream<AuthState> get onAuthStateChange => const Stream.empty();
}

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final mockSupabase = MockSupabaseClient();
    final fakeAuth = FakeGoTrueClient();
    when(() => mockSupabase.auth).thenReturn(fakeAuth);

    // Construimos la App envuelta en un ProviderScope para que Riverpod funcione.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          supabaseClientProvider.overrideWithValue(mockSupabase),
        ],
        child: const WdidApp(),
      ),
    );

    // Esperamos a que se resuelvan los frames iniciales (AuthGate cargando, etc).
    await tester.pump();

    // Verificación mínima: el widget raíz de la app existe.
    expect(find.byType(WdidApp), findsOneWidget);
  });
}
