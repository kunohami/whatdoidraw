import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatdoidraw/core/providers/locale_provider.dart';
import 'package:whatdoidraw/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Construimos la App envuelta en un ProviderScope para que Riverpod funcione.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const WdidApp(),
      ),
    );

    // Esperamos a que se resuelvan los frames iniciales (AuthGate cargando, etc).
    await tester.pump();

    // Verificación mínima: el widget raíz de la app existe.
    expect(find.byType(WdidApp), findsOneWidget);
  });
}
