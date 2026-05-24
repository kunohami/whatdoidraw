import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';

/// Provider para cachéar la obtención de doodles por ID
final doodleByIdProvider = FutureProvider.family<DoodleModel?, String>((
  ref,
  doodleId,
) async {
  final profileService = ref.watch(profileServiceProvider);
  return profileService.getDoodleById(doodleId);
});

class DoodleAvatar extends ConsumerWidget {
  final String? avatarUrl;
  final double radius;

  const DoodleAvatar({super.key, this.avatarUrl, this.radius = 50.0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (avatarUrl == null || avatarUrl!.isEmpty) {
      return _buildDefaultAvatar(context);
    }

    // Verificar si es un enlace web normal
    if (avatarUrl!.startsWith('http://') || avatarUrl!.startsWith('https://')) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        backgroundImage: NetworkImage(avatarUrl!),
      );
    }

    // Verificar si es el esquema personalizado de doodle
    if (avatarUrl!.startsWith('doodle:')) {
      return _buildDoodleAvatar(context, ref, avatarUrl!);
    }

    return _buildDefaultAvatar(context);
  }

  Widget _buildDefaultAvatar(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Icon(Icons.person, size: radius),
    );
  }

  Widget _buildDoodleAvatar(
    BuildContext context,
    WidgetRef ref,
    String uriString,
  ) {
    final uri = Uri.parse(uriString);
    final doodleId = uri.path;

    // Obtener parámetros de transformación, con valores por defecto si fallan
    final scale = double.tryParse(uri.queryParameters['s'] ?? '1.0') ?? 1.0;
    final tx = double.tryParse(uri.queryParameters['tx'] ?? '0.0') ?? 0.0;
    final ty = double.tryParse(uri.queryParameters['ty'] ?? '0.0') ?? 0.0;
    final bd = double.tryParse(uri.queryParameters['bd'] ?? '300.0') ?? 300.0;

    final diameter = radius * 2;

    // Obtenemos el doodle asíncronamente
    final doodleAsyncValue = ref.watch(doodleByIdProvider(doodleId));
    final doodle = doodleAsyncValue.asData?.value;
    final bgColor = doodle != null
        ? Color(doodle.backgroundColorValue)
        : Colors.white;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
      clipBehavior: Clip.antiAlias, // Hace la máscara circular
      child: doodleAsyncValue.when(
        data: (doodle) {
          if (doodle == null) return _buildDefaultAvatar(context);

          // Calculamos la relación de escala entre la dimensión base (ej. 300) y nuestro diámetro actual (ej. 100)
          final ratio = diameter / bd;

          return Transform(
            // Primero escalamos todo al tamaño final (ratio),
            // luego aplicamos la matriz que el usuario configuró (scale, tx, ty referenciados a bd).
            // Esto asegura que la matriz del InteractiveViewer se vea idéntica sin importar el tamaño del avatar.
            transform: Matrix4.identity()
              ..multiply(Matrix4.diagonal3Values(ratio, ratio, 1.0))
              ..multiply(Matrix4.translationValues(tx, ty, 0.0))
              ..multiply(Matrix4.diagonal3Values(scale, scale, 1.0)),
            alignment: Alignment.topLeft,
            child: OverflowBox(
              minWidth: bd,
              maxWidth: bd,
              minHeight: bd,
              maxHeight: bd,
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: bd,
                height: bd,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: 600,
                      height: 800,
                      child: CustomPaint(
                        size: const Size(600, 800),
                        painter: DoodlePainter(strokes: doodle.strokes),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (error, stack) => const Center(child: Icon(Icons.error_outline)),
      ),
    );
  }
}
