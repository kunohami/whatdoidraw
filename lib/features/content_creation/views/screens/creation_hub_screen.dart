import 'package:flutter/material.dart';

import 'package:whatdoidraw/features/bookmarks/views/screens/bookmarks_screen.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/create_idea_screen.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/doodle_canvas_screen.dart';

// [DOC]: Esta pantalla actúa como un "Hub" o enrutador visual.
// Ya no obliga al usuario a rellenar texto al pulsar 'Crear',
// sino que despliega las ramificaciones de arquitectura de negocio definidas
// en AI_CONTEXT.md (Idea, Doodle o Artwork).

class CreationHubScreen extends StatelessWidget {
  const CreationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¿Qué vamos a crear hoy?'),
        centerTitle: true,
      ),
      // [DOC]: ListView con separaciones para un listado de menú limpio nativo M3.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCard(
            context: context,
            title: 'Nueva Idea',
            subtitle: 'Escribe un prompt para desafiar a los dibujantes.',
            icon: Icons.lightbulb_outline,
            onTap: () {
              // [DOC]: Navigator.push apila la pantalla nueva encima del Hub.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateIdeaScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context: context,
            title: 'Nuevo Doodle',
            subtitle: 'Abre el lienzo y dibuja por tu cuenta.',
            icon: Icons.brush,
            onTap: () {
              // Lanzamos el motor de pintura que construimos anteriormente.
              // Como no depende de una idea previa, los parámetros son nulos.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DoodleCanvasScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context: context,
            title: 'Compartir Artwork',
            subtitle: 'Enlaza tu obra final conectándola a una inspiración.',
            icon: Icons.image_outlined,
            onTap: () {
              _showConstructionSnackbar(context);
            },
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          _buildMenuCard(
            context: context,
            title: 'Guardados',
            subtitle: 'Tus ideas y doodles favoritos listos para usar.',
            icon: Icons.bookmark,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookmarksScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // [DOC]: Un 'Widget Builder' auxiliar para no repetir el mismo código de las tarjetas (DRY - Don't Repeat Yourself).
  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip
          .antiAlias, // [DOC]: Evita que el efecto "tinta" de presionado (Ripple) se salga de las esquinas redondas
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                icon,
                size: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showConstructionSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad en construcción 🏗️'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
