import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/doodle_canvas_viewmodel.dart';
import '../widgets/doodle_painter.dart';

/// Pantalla principal para la creación de dibujos vectoriales (Doodles).
/// 
/// Utiliza un [ConsumerWidget] para reaccionar a los cambios en [DoodleCanvasState].
/// Implementa un patrón declarativo donde la UI se adapta según si el usuario
/// está dibujando, enviando datos o si ha ocurrido un error.
class DoodleCanvasScreen extends ConsumerWidget {
  /// Identificador de la idea que inspiró este dibujo (opcional).
  final String? ideaId;
  
  /// Texto de la idea para mostrarlo como marca de agua.
  final String? ideaPrompt;

  const DoodleCanvasScreen({
    super.key,
    this.ideaId,
    this.ideaPrompt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observamos el estado completo del lienzo.
    final canvasState = ref.watch(doodleCanvasProvider);
    
    // Escuchamos reactivamente los mensajes de error para mostrarlos sin bloquear la UI.
    ref.listen(doodleCanvasProvider.select((s) => s.errorMessage), (prev, next) {
      if (next != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Doodle'),
        actions: [
          // Botón Deshacer: Deshabilitado si no hay trazos o si se está enviando.
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: canvasState.isSubmitting || canvasState.strokes.isEmpty 
                ? null 
                : () => ref.read(doodleCanvasProvider.notifier).undo(),
            tooltip: 'Deshacer último trazo',
          ),
          // Botón Limpiar: Borra todo el lienzo.
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: canvasState.isSubmitting || canvasState.strokes.isEmpty 
                ? null 
                : () => ref.read(doodleCanvasProvider.notifier).clear(),
            tooltip: 'Limpiar lienzo',
          ),
          const SizedBox(width: 8),
          // Botón Publicar: Muestra estado de carga si es necesario.
          canvasState.isSubmitting 
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton.tonal(
                  onPressed: canvasState.strokes.isEmpty 
                      ? null 
                      : () async {
                          await ref.read(doodleCanvasProvider.notifier).submitDoodle(ideaId);
                          // Si tras el envío el lienzo se limpió (éxito), volvemos atrás.
                          if (context.mounted && ref.read(doodleCanvasProvider).strokes.isEmpty) {
                            Navigator.pop(context);
                          }
                        },
                  child: const Text('PUBLICAR'),
                ),
              ),
        ],
      ),
      body: Stack(
        children: [
          // Capa de fondo
          Container(color: Theme.of(context).scaffoldBackgroundColor),
          
          // Marca de agua para inspiración (Texto de la idea base)
          if (ideaPrompt != null)
            Center(
              child: Opacity(
                opacity: 0.08,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    ideaPrompt!,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

          // Área interactiva de dibujo
          AbsorbPointer(
            absorbing: canvasState.isSubmitting, // Bloquea el dibujo mientras se sube
            child: GestureDetector(
              onPanStart: (details) {
                ref.read(doodleCanvasProvider.notifier)
                    .startStroke(details.localPosition.dx, details.localPosition.dy);
              },
              onPanUpdate: (details) {
                ref.read(doodleCanvasProvider.notifier)
                    .updateStroke(details.localPosition.dx, details.localPosition.dy);
              },
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
                child: CustomPaint(
                  painter: DoodlePainter(strokes: canvasState.strokes),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          
          // Overlay de carga bloqueante (opcional, ya tenemos el spinner arriba)
          if (canvasState.isSubmitting)
            Container(
              color: Colors.black12,
              child: const Center(child: Text('Subiendo tu obra...')),
            ),
        ],
      ),
    );
  }
}
