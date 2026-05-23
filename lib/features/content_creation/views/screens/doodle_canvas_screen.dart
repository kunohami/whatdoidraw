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

          // Área interactiva de dibujo (Estática y alineada arriba para evitar solapamientos)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(canvasState.backgroundColor),
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
          ),

          // Barra de controles de dibujo inferior flotante (Overlay)
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              top: false,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Bandeja de herramientas contextuales
                      _buildContextualTray(context, ref, canvasState),
                      if (canvasState.activeTool == DrawingTool.pen || canvasState.activeTool == DrawingTool.brush)
                        const Divider(height: 16),
                      // Fila de herramientas
                      _buildToolsRow(context, ref, canvasState),
                    ],
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

  Widget _buildToolsRow(BuildContext context, WidgetRef ref, DoodleCanvasState state) {
    final notifier = ref.read(doodleCanvasProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ToolButton(
          icon: Icons.edit,
          label: 'Línea',
          isSelected: state.activeTool == DrawingTool.pen,
          onTap: () => notifier.selectTool(DrawingTool.pen),
        ),
        _ToolButton(
          icon: Icons.brush,
          label: 'Pincel',
          isSelected: state.activeTool == DrawingTool.brush,
          onTap: () => notifier.selectTool(DrawingTool.brush),
        ),
        _ToolButton(
          icon: Icons.layers_clear,
          label: 'Borrar Línea',
          isSelected: state.activeTool == DrawingTool.eraserLine,
          onTap: () => notifier.selectTool(DrawingTool.eraserLine),
        ),
        _ToolButton(
          icon: Icons.format_color_reset,
          label: 'Borrar Color',
          isSelected: state.activeTool == DrawingTool.eraserColor,
          onTap: () => notifier.selectTool(DrawingTool.eraserColor),
        ),
        _ToolButton(
          icon: Icons.color_lens_outlined,
          label: 'Fondo',
          isSelected: false,
          onTap: () => _showBackgroundDialog(context, ref, state.backgroundColor),
        ),
      ],
    );
  }

  Widget _buildContextualTray(BuildContext context, WidgetRef ref, DoodleCanvasState state) {
    final notifier = ref.read(doodleCanvasProvider.notifier);

    final brushColors = [
      0xFF000000, // Negro
      0xFFE53935, // Rojo vibrante
      0xFFD81B60, // Rosa vibrante
      0xFF8E24AA, // Púrpura vibrante
      0xFF3949AB, // Índigo vibrante
      0xFF1E88E5, // Azul vibrante
      0xFF00ACC1, // Cian vibrante
      0xFF43A047, // Verde vibrante
      0xFFFDD835, // Amarillo vibrante
      0xFFFB8C00, // Naranja vibrante
      0xFF7D4F3D, // Marrón vibrante
    ];

    if (state.activeTool == DrawingTool.pen || state.activeTool == DrawingTool.brush) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (state.activeTool == DrawingTool.brush) ...[
            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: brushColors.length,
                itemBuilder: (context, idx) {
                  final color = brushColors[idx];
                  final isSelected = state.brushColor == color;
                  return GestureDetector(
                    onTap: () => notifier.setBrushColor(color),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Color(color),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                size: 14,
                                color: color == 0xFFFFFFFF ? Colors.black : Colors.white,
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              Icon(
                state.activeTool == DrawingTool.pen ? Icons.edit : Icons.brush,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                  ),
                  child: Slider(
                    min: 1.0,
                    max: 20.0,
                    value: state.strokeWidth,
                    onChanged: (val) => notifier.setStrokeWidth(val),
                  ),
                ),
              ),
              Text(
                '${state.strokeWidth.toStringAsFixed(0)} px',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      );
    }

    if (state.activeTool == DrawingTool.eraserLine) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          'Borrador de Líneas activo. Pasa el dedo por una línea para borrarla.',
          style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      );
    }

    if (state.activeTool == DrawingTool.eraserColor) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          'Borrador de Color activo. Pasa el dedo por una pincelada para borrarla.',
          style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void _showBackgroundDialog(BuildContext context, WidgetRef ref, int currentColor) {
    final colors = [
      0xFFFFFFFF,
      0xFFFAFAFA,
      0xFFFFF9C4,
      0xFFFFE0B2,
      0xFFFFCDD2,
      0xFFE1BEE7,
      0xFFD1C4E9,
      0xFFBBDEFB,
      0xFFB2EBF2,
      0xFFC8E6C9,
      0xFFDCEDC8,
      0xFFECEFF1,
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Color del Fondo'),
        content: SizedBox(
          width: 300,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: colors.length,
            itemBuilder: (context, idx) {
              final color = colors[idx];
              final isSelected = currentColor == color;
              return GestureDetector(
                onTap: () {
                  ref.read(doodleCanvasProvider.notifier).setBackgroundColor(color);
                  Navigator.pop(ctx);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(color),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade300,
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: color == 0xFFFFFFFF || color == 0xFFFAFAFA
                              ? Colors.black
                              : Colors.white,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToolButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primaryContainer
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
