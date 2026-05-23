import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/core/providers/locale_provider.dart';
import 'package:whatdoidraw/core/providers/supabase_provider.dart';
import 'package:whatdoidraw/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:whatdoidraw/features/profile/views/screens/settings_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/user_model.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class FakeGoTrueClient extends Fake implements GoTrueClient {
  @override
  User? get currentUser => FakeUser();
}

class FakeUser extends Fake implements User {
  @override
  String get email => 'test@example.com';
}

void main() {
  testWidgets('Settings language dropdown changes app locale and text', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final mockSupabase = MockSupabaseClient();
    final fakeAuth = FakeGoTrueClient();
    when(() => mockSupabase.auth).thenReturn(fakeAuth);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          supabaseClientProvider.overrideWithValue(mockSupabase),
          currentUserProfileProvider.overrideWith(
            (ref) => const UserModel(id: 'test-user-id', username: 'test_user'),
          ),
        ],
        child: Consumer(
          builder: (context, ref, _) {
            final currentLocale = ref.watch(appLocaleProvider);
            return MaterialApp(
              locale: currentLocale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const SettingsScreen(),
            );
          },
        ),
      ),
    );

    // El entorno de test por defecto inicia en inglés
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);

    // Buscamos el dropdown y lo abrimos
    final dropdownFinder = find.byType(DropdownButton<String>);
    expect(dropdownFinder, findsOneWidget);
    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle();

    // Buscamos la opción 'Español' en el menú flotante
    // Al abrir el dropdown, se duplica el widget en el menú
    final spanishItemFinder = find.text('Español').last;
    await tester.tap(spanishItemFinder);
    await tester.pumpAndSettle();

    // Verificamos si los textos han cambiado a español
    expect(find.text('Ajustes'), findsOneWidget);
    expect(find.text('Idioma'), findsOneWidget);
  });
}
