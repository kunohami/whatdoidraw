import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Un widget que renderiza una imagen de mascota con un efecto de "jitter"
/// estilo stop-motion / boiling lines (líneas hirvientes).
///
/// Simula la animación tradicional dibujada a mano aplicando sutiles variaciones
/// de rotación, posición y escala a intervalos rápidos (6 FPS).
class MascotJitterWidget extends StatefulWidget {
  /// Ruta del asset de la imagen a renderizar.
  final String imagePath;

  /// Ancho de la mascota.
  final double width;

  /// Alto de la mascota.
  final double height;

  /// Si es verdadero, aplica el efecto de jitter. De lo contrario, se queda estático.
  final bool animate;

  const MascotJitterWidget({
    super.key,
    this.imagePath = 'assets/images/mascot_idle.png',
    this.width = 180.0,
    this.height = 180.0,
    this.animate = true,
  });

  @override
  State<MascotJitterWidget> createState() => _MascotJitterWidgetState();
}

class _MascotJitterWidgetState extends State<MascotJitterWidget> {
  Timer? _timer;
  final math.Random _random = math.Random();

  // Valores de transformación actuales
  double _rotation = 0.0;
  double _translationX = 0.0;
  double _translationY = 0.0;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _startJitter();
    }
  }

  @override
  void didUpdateWidget(covariant MascotJitterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _startJitter();
      } else {
        _stopJitter();
      }
    }
  }

  @override
  void dispose() {
    _stopJitter();
    super.dispose();
  }

  void _startJitter() {
    _timer?.cancel();
    // 6 FPS = ~166 ms por fotograma. Esto le da una vibra clásica de animación stop-motion.
    _timer = Timer.periodic(const Duration(milliseconds: 160), (timer) {
      if (!mounted) return;
      setState(() {
        // Rotación sutil: entre -0.015 y +0.015 radianes
        _rotation = (_random.nextDouble() - 0.5) * 0.03;

        // Desplazamiento sutil: entre -1.5 y +1.5 píxeles en cada eje
        _translationX = (_random.nextDouble() - 0.5) * 3.0;
        _translationY = (_random.nextDouble() - 0.5) * 3.0;

        // Escala sutil: entre 0.985 y 1.015
        _scale = 0.985 + (_random.nextDouble() * 0.03);
      });
    });
  }

  void _stopJitter() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _rotation = 0.0;
      _translationX = 0.0;
      _translationY = 0.0;
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.translationValues(_translationX, _translationY, 0.0)
        ..rotateZ(_rotation)
        ..multiply(Matrix4.diagonal3Values(_scale, _scale, 1.0)),
      child: Image.asset(
        widget.imagePath,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain,
        // Evitamos el difuminado durante transformaciones rápidas de escala/rotación
        filterQuality: FilterQuality.medium,
        errorBuilder: (context, error, stackTrace) {
          // Fallback elegante por si no encuentra la imagen
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[600]!, width: 2),
            ),
            child: const Icon(
              Icons.face,
              size: 48,
              color: Colors.white70,
            ),
          );
        },
      ),
    );
  }
}
