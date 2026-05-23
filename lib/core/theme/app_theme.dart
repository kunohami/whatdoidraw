import 'package:flutter/material.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';

/// Enum con el catálogo de temas de la aplicación.
enum AppThemeMode {
  dark,
  light,
  darkGreen,
  darkPlus;

  /// Obtiene el nombre localizado del tema en tiempo real según el idioma de la app.
  String getLocalizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case AppThemeMode.dark:
        return l10n.themeDark;
      case AppThemeMode.light:
        return l10n.themeLight;
      case AppThemeMode.darkGreen:
        return l10n.themeDarkGreen;
      case AppThemeMode.darkPlus:
        return l10n.themeDarkPlus;
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
      case AppThemeMode.light:
        return ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFFFFFF), // 60% White
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF008080), // 10% Muted Teal Seed
            brightness: Brightness.light,
            primary: const Color(0xFF008080), // 10% Muted Teal
            surface: const Color(0xFFFFFFFF), // 60% White Background
            onSurface: const Color(0xFF1A202C), // 30% Deep Charcoal Text
            onSurfaceVariant: const Color(0xFF1A202C).withValues(alpha: 0.7),
          ),
        );
      case AppThemeMode.darkGreen:
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.tealAccent,
            brightness: Brightness.dark,
            surface: const Color(0xFF0F1E1A),
            surfaceContainerHighest: const Color(0xFF162B25),
          ),
        );
      case AppThemeMode.darkPlus:
        return ThemeData(
          useMaterial3: true,
          // Hacemos el fondo transparente para que el widget DarkPlusBackground sea visible
          scaffoldBackgroundColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurpleAccent,
            brightness: Brightness.dark,
          ),
        );
    }
  }
}

/// Widget encargado de renderizar un fondo animado fluido y sutil.
/// Exclusivo para el tema "Oscuro Plus" (Dark Plus).
class DarkPlusBackground extends StatefulWidget {
  final Widget child;

  const DarkPlusBackground({super.key, required this.child});

  @override
  State<DarkPlusBackground> createState() => _DarkPlusBackgroundState();
}

class _DarkPlusBackgroundState extends State<DarkPlusBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        seconds: 4,
      ), // Movimiento vivo, fluido y perfectamente visible
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final t = _animation.value;

        // Desplazamiento muy suave de las alineaciones del gradiente
        final begin = Alignment(-1.5 + t * 0.4, -1.5 + t * 0.4);
        final end = Alignment(1.5 - t * 0.4, 1.5 - t * 0.4);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: const [
                Color(
                  0xFF090712,
                ), // Fondo base morado-negro ultra profundo (mayor contraste)
                Color(0xFF2E1554), // Morado medio de transición
                Color(0xFF0D0A1C), // Base de sombra
                Color(
                  0xFF531F89,
                ), // Brillo morado radiante de alto impacto visual
              ],
              stops: [0.0, 0.35, 0.65, 1.0],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
