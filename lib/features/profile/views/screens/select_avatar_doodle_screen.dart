import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:whatdoidraw/features/profile/views/screens/adjust_avatar_screen.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';

class SelectAvatarDoodleScreen extends ConsumerWidget {
  const SelectAvatarDoodleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doodlesAsync = ref.watch(currentUserDoodlesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Doodle')),
      body: doodlesAsync.when(
        data: (doodles) {
          if (doodles.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.brush, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No tienes ningún doodle todavía.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Crea uno primero para poder usarlo como foto de perfil.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: doodles.length,
            itemBuilder: (context, index) {
              final doodle = doodles[index];
              final strokes = doodle.doodleData
                  .map((e) => StrokeModel.fromJson(e as Map<String, dynamic>))
                  .toList();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdjustAvatarScreen(doodle: doodle),
                    ),
                  );
                },
                child: Hero(
                  tag: 'avatar_doodle_${doodle.id}',
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 1,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
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
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
