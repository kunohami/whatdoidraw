import 'package:flutter/material.dart';

/// Chip de solo lectura que muestra una etiqueta en las tarjetas del Feed.
///
/// Al pulsarlo, invoca el callback [onTap] para que la pantalla padre
/// pueda filtrar el feed por ese tag. Si [onTap] es null, el chip
/// es meramente decorativo.
class TagChip extends StatelessWidget {
  /// Texto de la etiqueta a mostrar (sin el símbolo #).
  final String tag;

  /// Callback opcional que se invoca al pulsar el chip.
  final VoidCallback? onTap;

  /// Si es true, el chip se muestra con un estilo "activo" (seleccionado).
  final bool isActive;

  const TagChip({
    super.key,
    required this.tag,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? colorScheme.primary : colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: Text(
          '#$tag',
          style: TextStyle(
            fontSize: 12,
            color: isActive
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
