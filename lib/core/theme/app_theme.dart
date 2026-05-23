import 'package:flutter/material.dart';

/// Enum con el catálogo de temas de la aplicación.
enum AppThemeMode {
  dark,
  sakuraLight,
  forestDark;

  String get displayName {
    switch (this) {
      case AppThemeMode.dark:
        return 'Oscuro (Dark)';
      case AppThemeMode.sakuraLight:
        return 'Sakura Claro';
      case AppThemeMode.forestDark:
        return 'Bosque Profundo';
    }
  }
}

/// Clase utilitaria encargada de generar los `ThemeData` correspondientes
/// a cada modo de tema utilizando esquemas de color semilla modernos de Material 3.
class AppThemes {
  static ThemeData getThemeData(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurpleAccent,
            brightness: Brightness.dark,
          ),
        );
      case AppThemeMode.sakuraLight:
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pinkAccent,
            brightness: Brightness.light,
          ),
        );
      case AppThemeMode.forestDark:
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.tealAccent,
            brightness: Brightness.dark,
            surface: const Color(0xFF0F1E1A),
            surfaceContainerHighest: const Color(0xFF162B25),
          ),
        );
    }
  }
}
