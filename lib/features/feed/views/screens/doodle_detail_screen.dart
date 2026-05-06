import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/artworks/presentation/screens/create_artwork_screen.dart';
import 'package:whatdoidraw/features/content_creation/services/content_creation_service.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/doodle_canvas_screen.dart';
import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';

/// Pantalla que presenta un Doodle a tamaño completo con opciones interactivas.
///
/// Evalúa automáticamente si el usuario autenticado es el creador del Doodle
/// para habilitar controles como [Eliminar]. Si no lo es, permite [Compartir] o [Inspirarse].
class DoodleDetailScreen extends ConsumerWidget {
  final DoodleModel doodle;

  const DoodleDetailScreen({super.key, required this.doodle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos el perfil del creador en sesión para comprobaciones de propiedad
    final currentUser = ref.watch(authControllerProvider).value;
    final isCreator = currentUser?.id == doodle.userId;

    final strokes = doodle.doodleData
        .map((e) => StrokeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Doodle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Compartir Artwork',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Próximamente: Integración con Redes o Exportar Imagen.',
                  ),
                ),
              );
            },
          ),
          if (isCreator)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: 'Eliminar dibujo',
              onPressed: () => _confirmDeletion(context, ref),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              // Permite hacer zoom sutil a los dibujos para ver el detalle de los trazos.
              maxScale: 3.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox(
                          width: 600,
                          height: 800,
                          child: CustomPaint(
                            painter: DoodlePainter(strokes: strokes),
                            size: const Size(600, 800),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoodleCanvasScreen(
                            ideaId: doodle.ideaId,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.brush),
                    label: const Text('Crear otro'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateArtworkScreen(
                            doodleId: doodle.id,
                            initialTags: doodle.tags,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.publish_outlined),
                    label: const Text('Artwork final'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      foregroundColor: Theme.of(context).colorScheme.onTertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeletion(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar Doodle?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                // Delegamos la eliminación al ViewModel o Service
                await ref
                    .read(contentCreationServiceProvider)
                    .deleteDoodle(doodle.id);

                if (context.mounted) {
                  Navigator.pop(context); // Vuelve atrás tras eliminar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Doodle eliminado correctamente'),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al eliminar: $e')),
                  );
                }
              }
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
