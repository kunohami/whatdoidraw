import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatdoidraw/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    // Construimos la App envuelta en un ProviderScope para que Riverpod funcione.
    await tester.pumpWidget(
      const ProviderScope(
        child: WdidApp(),
      ),
    );

    // Esperamos a que se resuelvan los frames iniciales (AuthGate cargando, etc).
    await tester.pump();

    // Verificación mínima: el widget raíz de la app existe.
    expect(find.byType(WdidApp), findsOneWidget);
  });
}
