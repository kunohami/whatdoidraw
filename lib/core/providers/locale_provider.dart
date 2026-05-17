import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_provider.g.dart';

/// Provider que expone la instancia de SharedPreferences de manera síncrona.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden in main.dart');
});

/// Notifier que maneja el idioma global de la aplicación.
///
/// Inicialmente detecta el idioma guardado en SharedPreferences, o en su defecto
/// el idioma del sistema, y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar
/// el idioma en tiempo real sin reiniciar la app.
@riverpod
class AppLocale extends _$AppLocale {
  static const _localeKey = 'app_locale';

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedLanguageCode = prefs.getString(_localeKey);
    
    if (savedLanguageCode != null) {
      return Locale(savedLanguageCode);
    }

    // Si no hay idioma guardado, detectamos si el idioma del sistema empieza por 'es'.
    final systemLocale = PlatformDispatcher.instance.locale.languageCode;
    return Locale(systemLocale.startsWith('es') ? 'es' : 'en');
  }

  /// Cambia el idioma actual de la aplicación y lo guarda de forma persistente.
  void setLocale(Locale newLocale) {
    state = newLocale;
    ref.read(sharedPreferencesProvider).setString(_localeKey, newLocale.languageCode);
  }
}
