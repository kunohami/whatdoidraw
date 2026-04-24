import 'package:flutter/material.dart';

/// Botón que permite al usuario cargar más contenido paginado en el Feed.
///
/// Se muestra solo cuando [hasMore] es true. Mientras se está cargando,
/// muestra un indicador de progreso en lugar del texto.
class LoadMoreButton extends StatelessWidget {
  /// Indica si hay más páginas disponibles.
  final bool hasMore;

  /// Indica si se está cargando la siguiente página actualmente.
  final bool isLoading;

  /// Callback que se invoca al pulsar el botón.
  final VoidCallback onPressed;

  /// Texto del botón en modo aleatoria (barajar de nuevo).
  final bool isRandomMode;

  const LoadMoreButton({
    super.key,
    required this.hasMore,
    required this.isLoading,
    required this.onPressed,
    this.isRandomMode = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasMore && !isRandomMode) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(isRandomMode ? Icons.shuffle : Icons.expand_more),
          label: Text(
            isLoading
                ? 'Cargando...'
                : isRandomMode
                ? 'Barajar de nuevo'
                : 'Ver más',
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
