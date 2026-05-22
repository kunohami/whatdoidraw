import 'package:flutter/material.dart';
import 'package:whatdoidraw/shared/widgets/mascot_jitter_widget.dart';

/// Define un paso individual dentro del sistema de tutoriales.
class TutorialStep {
  /// El texto explicativo que dirá la mascota.
  final String text;

  /// La ruta opcional de la imagen de la mascota para este paso.
  /// Permite cambiar las expresiones (ej. hablando, alegre, pensativo).
  final String? imagePath;

  const TutorialStep({
    required this.text,
    this.imagePath,
  });
}

/// Un overlay a pantalla completa que oscurece el fondo y muestra a la mascota
/// en la esquina inferior derecha interactuando con un bocadillo de diálogo (speech bubble)
/// centrado en la pantalla.
class TutorialOverlay extends StatefulWidget {
  /// Lista de pasos del tutorial.
  final List<TutorialStep> steps;

  /// Callback cuando el usuario completa todos los pasos del tutorial.
  final VoidCallback? onComplete;

  /// Callback cuando el usuario cancela/salta el tutorial mediante el botón "X".
  final VoidCallback? onSkip;

  const TutorialOverlay({
    super.key,
    required this.steps,
    this.onComplete,
    this.onSkip,
  });

  /// Método de conveniencia para mostrar el tutorial de forma limpia como una ruta transparente.
  static Future<void> show(
    BuildContext context, {
    required List<TutorialStep> steps,
    VoidCallback? onComplete,
    VoidCallback? onSkip,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // Permite ver la pantalla inferior a través del fondo translúcido
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: TutorialOverlay(
              steps: steps,
              onComplete: onComplete,
              onSkip: onSkip,
            ),
          );
        },
      ),
    );
  }

  /// Muestra el tutorial general de bienvenida / onboarding.
  static Future<void> showGeneral(
    BuildContext context,
    dynamic l10n, {
    VoidCallback? onComplete,
    VoidCallback? onSkip,
  }) {
    final steps = [
      TutorialStep(text: l10n.tutorialWelcome),
      TutorialStep(text: l10n.tutorialConcept),
      TutorialStep(text: l10n.tutorialIdeas),
      TutorialStep(text: l10n.tutorialDoodles),
      TutorialStep(text: l10n.tutorialArtworks),
      TutorialStep(text: l10n.tutorialReady),
    ];
    return show(
      context,
      steps: steps,
      onComplete: onComplete,
      onSkip: onSkip,
    );
  }

  /// Muestra la ayuda contextual de la pestaña activa en el Feed.
  static Future<void> showFeedInfo(
    BuildContext context,
    dynamic l10n,
    int activeTab,
  ) {
    String text;
    if (activeTab == 0) {
      text = l10n.infoFeedIdeas;
    } else if (activeTab == 1) {
      text = l10n.infoFeedDoodles;
    } else {
      text = l10n.infoFeedArtworks;
    }
    return show(context, steps: [TutorialStep(text: text)]);
  }

  /// Muestra la ayuda en el Centro de Creación.
  static Future<void> showCreationHubInfo(
    BuildContext context,
    dynamic l10n,
  ) {
    return show(
      context,
      steps: [TutorialStep(text: l10n.infoCreationHub)],
    );
  }

  /// Muestra la ayuda en la pantalla de Crear Idea.
  static Future<void> showCreateIdeaInfo(
    BuildContext context,
    dynamic l10n,
  ) {
    return show(
      context,
      steps: [TutorialStep(text: l10n.infoCreateIdea)],
    );
  }

  /// Muestra la ayuda en el Lienzo del Doodle.
  static Future<void> showDoodleCanvasInfo(
    BuildContext context,
    dynamic l10n,
  ) {
    return show(
      context,
      steps: [TutorialStep(text: l10n.infoDoodleCanvas)],
    );
  }

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  int _currentStepIndex = 0;

  void _nextStep() {
    if (_currentStepIndex < widget.steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
    } else {
      Navigator.of(context).pop();
      widget.onComplete?.call();
    }
  }

  void _skipTutorial() {
    Navigator.of(context).pop();
    widget.onSkip?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.steps.isEmpty) return const SizedBox.shrink();

    final currentStep = widget.steps[_currentStepIndex];
    final isLastStep = _currentStepIndex == widget.steps.length - 1;

    // Colores premium con alto contraste para legibilidad
    const bubbleBgColor = Colors.white;
    const bubbleTextColor = Colors.black87;

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.75), // Oscurece el fondo de la app
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Botón "X" sutil pero perfectamente visible en la esquina superior derecha para saltar
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white70,
                  size: 28,
                ),
                tooltip: 'Saltar tutorial',
                onPressed: _skipTutorial,
              ),
            ),

            // 2. Bocadillo de diálogo (Speech Bubble) centrado en la pantalla
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // El contenedor principal del bocadillo
                      Material(
                      elevation: 12,
                      color: bubbleBgColor,
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 500, // Evita que en tablets se vea excesivamente ancho
                          minHeight: 150,
                        ),
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Texto explicativo (Soporta múltiples líneas y textos largos)
                            Expanded(
                              flex: 0,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: Text(
                                  currentStep.text,
                                  key: ValueKey<int>(_currentStepIndex),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                    color: bubbleTextColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Fila de acciones del bocadillo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Indicador de progreso (ej. "1 / 4")
                                Text(
                                  '${_currentStepIndex + 1} / ${widget.steps.length}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: bubbleTextColor.withValues(alpha: 0.5),
                                  ),
                                ),
                                // Botón para continuar
                                ElevatedButton(
                                  onPressed: _nextStep,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurpleAccent,
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: Text(
                                    isLastStep ? '¡Empezar!' : 'Siguiente',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Pequeña colita del bocadillo apuntando hacia la mascota (abajo a la derecha)
                    Padding(
                      padding: const EdgeInsets.only(right: 60.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomPaint(
                          size: const Size(20, 15),
                          painter: TrianglePainter(color: bubbleBgColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 3. Mascota con Jitter (Wiggle) ubicada justo debajo de la colita
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Hero(
                          tag: 'mascot_tutorial',
                          child: MascotJitterWidget(
                            key: ValueKey<String>(currentStep.imagePath ?? 'default'),
                            imagePath: currentStep.imagePath ?? 'assets/images/mascot_idle.png',
                            width: 140,
                            height: 140,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}

/// Un pintor simple para dibujar la colita triangular del bocadillo de diálogo.
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
