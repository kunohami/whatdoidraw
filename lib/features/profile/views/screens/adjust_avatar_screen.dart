import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';

class AdjustAvatarScreen extends ConsumerStatefulWidget {
  final DoodleModel doodle;

  const AdjustAvatarScreen({super.key, required this.doodle});

  @override
  ConsumerState<AdjustAvatarScreen> createState() => _AdjustAvatarScreenState();
}

class _AdjustAvatarScreenState extends ConsumerState<AdjustAvatarScreen> {
  late final TransformationController _transformationController;
  bool _isSaving = false;

  static const double baseDimension = 300.0;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _resetTransform() {
    _transformationController.value = Matrix4.identity();
  }

  Future<void> _saveAvatar() async {
    final user = await ref.read(authControllerProvider.future);
    if (user == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final matrix = _transformationController.value;
      
      // La matriz de transformación es una Matrix4 de 4x4.
      // scale es m00, tx es m03, ty es m13
      final scale = matrix.entry(0, 0);
      final tx = matrix.entry(0, 3);
      final ty = matrix.entry(1, 3);

      final uriString = 'doodle:${widget.doodle.id}?s=${scale.toStringAsFixed(3)}&tx=${tx.toStringAsFixed(1)}&ty=${ty.toStringAsFixed(1)}&bd=$baseDimension';

      await ref.read(profileServiceProvider).updateUserAvatar(user.id, uriString);
      
      // Forzamos actualización del perfil en caché
      ref.invalidate(userProfileProvider(user.id));
      ref.invalidate(currentUserProfileProvider);

      if (mounted) {
        // Pop back to profile screen
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustar Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetTransform,
            tooltip: 'Reiniciar',
          ),
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _saveAvatar,
              child: const Text('Guardar'),
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Usa tus dedos para arrastrar y hacer zoom. Lo que quede dentro del círculo será tu foto de perfil.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            // Avatar Mask
            Container(
              width: baseDimension,
              height: baseDimension,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: InteractiveViewer(
                transformationController: _transformationController,
                minScale: 0.1,
                maxScale: 10.0,
                boundaryMargin: const EdgeInsets.all(400.0), // Gran margen para total libertad de movimiento
                child: SizedBox(
                  width: baseDimension,
                  height: baseDimension,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: 600,
                        height: 800,
                        child: CustomPaint(
                          size: const Size(600, 800),
                          painter: DoodlePainter(
                            strokes: widget.doodle.doodleData
                                .map((e) => StrokeModel.fromJson(e as Map<String, dynamic>))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _resetTransform,
              icon: const Icon(Icons.center_focus_strong),
              label: const Text('Centrar doodle'),
            ),
          ],
        ),
      ),
    );
  }
}
