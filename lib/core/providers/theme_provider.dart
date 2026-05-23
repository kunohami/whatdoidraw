import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/core/providers/locale_provider.dart';
import 'package:whatdoidraw/core/theme/app_theme.dart';

part 'theme_provider.g.dart';

/// Notifier que maneja el tema visual global de la aplicación.
///
/// Inicialmente detecta el tema guardado en SharedPreferences, o en su defecto
/// el tema oscuro (dark), y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar
/// el tema en tiempo real sin reiniciar la app.
@riverpod
class AppThemeNotifier extends _$AppThemeNotifier {
  static const _themeKey = 'selected_theme_mode';

  @override
  AppThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedThemeIndex = prefs.getInt(_themeKey);

    if (savedThemeIndex != null &&
        savedThemeIndex < AppThemeMode.values.length) {
      return AppThemeMode.values[savedThemeIndex];
    }
    // Tema por defecto (Oscuro)
    return AppThemeMode.dark;
  }

  /// Cambia el tema actual de la aplicación y lo guarda de forma persistente.
  void setTheme(AppThemeMode mode) {
    state = mode;
    ref.read(sharedPreferencesProvider).setInt(_themeKey, mode.index);
  }
}
