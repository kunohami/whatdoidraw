import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatdoidraw/core/providers/locale_provider.dart';

void main() {
  test(
    'AppLocale notifier loads and saves chosen language in SharedPreferences',
    () async {
      // 1. Iniciar con SharedPreferences vacío
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      addTearDown(container.dispose);

      // Debe inicializar usando el valor por defecto ('en')
      final currentLocale = container.read(appLocaleProvider);
      expect(currentLocale.languageCode, equals('en'));

      // Cambiar a español 'es'
      container.read(appLocaleProvider.notifier).setLocale(const Locale('es'));
      expect(container.read(appLocaleProvider), equals(const Locale('es')));

      // Verificar que se guardó en SharedPreferences
      expect(prefs.getString('app_locale'), equals('es'));

      // 2. Simular un reinicio de la app usando las mismas preferencias con el valor guardado
      final restartContainer = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      addTearDown(restartContainer.dispose);

      // Debe cargar directamente 'es' en lugar del valor por defecto
      final loadedLocale = restartContainer.read(appLocaleProvider);
      expect(loadedLocale.languageCode, equals('es'));
    },
  );
}
