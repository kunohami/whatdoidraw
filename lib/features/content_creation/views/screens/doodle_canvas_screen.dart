import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/features/content_creation/viewmodels/doodle_canvas_viewmodel.dart';
import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/widgets/tag_input_field.dart';
import 'package:whatdoidraw/shared/widgets/tutorial_overlay.dart';

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

  const DoodleCanvasScreen({super.key, this.ideaId, this.ideaPrompt});

  /// Muestra un BottomSheet para añadir tags antes de publicar.
  Future<void> _showPublishSheet(
    BuildContext context,
    WidgetRef ref,
    String? ideaId,
  ) async {
    List<String> pendingTags = [];

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Añadir etiquetas',
                style: Theme.of(ctx).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Ayuda a otros a descubrir tu doodle con etiquetas descriptivas.',
                style: Theme.of(ctx).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (_, setState) =>
                    TagInputField(onTagsChanged: (tags) => pendingTags = tags),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Publicar Doodle'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        );
      },
    );

    if (confirmed == true && context.mounted) {
      ref.read(doodleCanvasProvider.notifier).setTags(pendingTags);
      await ref.read(doodleCanvasProvider.notifier).submitDoodle(ideaId);
      // Si tras el envío el lienzo se limpió (éxito), volvemos atrás.
      if (context.mounted && ref.read(doodleCanvasProvider).strokes.isEmpty) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observamos el estado completo del lienzo.
    final canvasState = ref.watch(doodleCanvasProvider);
    final l10n = AppLocalizations.of(context)!;

    // Escuchamos reactivamente los mensajes de error para mostrarlos sin bloquear la UI.
    ref.listen(doodleCanvasProvider.select((s) => s.errorMessage), (
      prev,
      next,
    ) {
      if (next != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), backgroundColor: Colors.redAccent),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Doodle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Ayuda',
            onPressed: () {
              TutorialOverlay.showDoodleCanvasInfo(context, l10n);
            },
          ),
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
          // Botón Publicar: Abre el BottomSheet de tags antes de publicar.
          canvasState.isSubmitting
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilledButton.tonal(
                    onPressed: canvasState.strokes.isEmpty
                        ? null
                        : () => _showPublishSheet(context, ref, ideaId),
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
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

          // Área interactiva de dibujo
          Center(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: AbsorbPointer(
                  absorbing: canvasState.isSubmitting,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: 600,
                      height: 800,
                      child: GestureDetector(
                        onPanStart: (details) {
                          ref
                              .read(doodleCanvasProvider.notifier)
                              .startStroke(
                                details.localPosition.dx,
                                details.localPosition.dy,
                              );
                        },
                        onPanUpdate: (details) {
                          ref
                              .read(doodleCanvasProvider.notifier)
                              .updateStroke(
                                details.localPosition.dx,
                                details.localPosition.dy,
                              );
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: double.infinity,
                          child: CustomPaint(
                            painter: DoodlePainter(
                              strokes: canvasState.strokes,
                            ),
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

          // Overlay de carga bloqueante
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
