import 'package:flutter/material.dart';

import 'package:whatdoidraw/features/bookmarks/views/screens/bookmarks_screen.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/create_idea_screen.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/doodle_canvas_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';

// [DOC]: Esta pantalla actúa como un "Hub" o enrutador visual.
// Ya no obliga al usuario a rellenar texto al pulsar 'Crear',
// sino que despliega las ramificaciones de arquitectura de negocio definidas
// en AI_CONTEXT.md (Idea, Doodle o Artwork).

class CreationHubScreen extends StatelessWidget {
  const CreationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.creationHubTitle), centerTitle: true),
      // [DOC]: ListView con separaciones para un listado de menú limpio nativo M3.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCard(
            context: context,
            title: l10n.creationHubNewIdea,
            subtitle: l10n.creationHubNewIdeaSubtitle,
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
            title: l10n.creationHubNewDoodle,
            subtitle: l10n.creationHubNewDoodleSubtitle,
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
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          _buildMenuCard(
            context: context,
            title: l10n.creationHubBookmarks,
            subtitle: l10n.creationHubBookmarksSubtitle,
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
}
