import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

/// Notifier que maneja el idioma global de la aplicación.
///
/// Inicialmente detecta el idioma del sistema y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar 
/// el idioma en tiempo real sin reiniciar la app.
@riverpod
class AppLocale extends _$AppLocale {
  @override
  Locale build() {
    // Detectamos si el idioma del sistema empieza por 'es'. Si no, por defecto a 'en'.
    final locale = PlatformDispatcher.instance.locale.languageCode;
    return Locale(locale.startsWith('es') ? 'es' : 'en');
  }

  /// Cambia el idioma actual de la aplicación.
  void setLocale(Locale newLocale) {
    state = newLocale;
  }
}
