import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/doodle_canvas_provider.dart';
import 'widgets/doodle_painter.dart';

class DoodleCanvasScreen extends ConsumerWidget {
  final String? ideaId; // Identificador enlazado (Foreign key)
  final String? ideaPrompt; // Texto base para no perder la inspiración

  const DoodleCanvasScreen({
    super.key,
    this.ideaId,
    this.ideaPrompt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [DOC]: Al hacer watch a provider de Riverpod, logramos que la pantalla
    // se remodele (Renderize) a cada fragmento minúsculo de actualización de un dedo.
    final strokes = ref.watch(doodleCanvasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Doodle'),
        // Botones de herraminentas
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () => ref.read(doodleCanvasProvider.notifier).undo(),
            tooltip: 'Deshacer (Quita el último trazo)',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => ref.read(doodleCanvasProvider.notifier).clear(),
            tooltip: 'Destruir lienzo',
          ),
          FilledButton.tonal(
            onPressed: () async {
              try {
                // Mandamos invocar el método de envío a red 
                await ref.read(doodleCanvasProvider.notifier).submitDoodle(ideaId);
                // Si todo sale bien, cerramos el lienzo: Navigator.pop()
                if (context.mounted) Navigator.pop(context); 
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: const Text('PUBLICAR'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Capa fondo oscuro base
          Container(color: Colors.black26),
          
          // Marca de agua: Promp debajo para ayudar al dibujante
          if (ideaPrompt != null)
            Positioned(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height * 0.3,
              child: Opacity(
                opacity: 0.15,
                child: Text(
                  ideaPrompt!,
                  style: const TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          // [DOC]: El corazón invisible que intercepta dedos físicos: GestureDetector
          GestureDetector(
            onPanStart: (details) {
              ref.read(doodleCanvasProvider.notifier)
                  .startStroke(details.localPosition.dx, details.localPosition.dy);
            },
            onPanUpdate: (details) {
              ref.read(doodleCanvasProvider.notifier)
                  .updateStroke(details.localPosition.dx, details.localPosition.dy);
            },
            child: Container(
              color: Colors.transparent, // Obligatorio pour que intercepte toda la caja
              width: double.infinity,
              height: double.infinity,
              
              // Aquí incrustamos al verdadero pintor crudo
              child: CustomPaint(
                painter: DoodlePainter(strokes: strokes),
                size: Size.infinite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
