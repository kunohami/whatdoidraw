import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/features/feed/viewmodels/feed_viewmodel.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';

/// Pantalla principal de Exploración ("Feed").
///
/// Divide el contenido público en tres categorías principales mediante pestañas:
/// Ideas, Doodles y Artworks (futuro).
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Descubrimiento'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.lightbulb_outline), text: 'Ideas'),
              Tab(icon: Icon(Icons.brush), text: 'Doodles'),
              Tab(icon: Icon(Icons.art_track), text: 'Artworks'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _IdeasFeedTab(),
            _DoodlesFeedTab(),
            _ArtworksFeedTab(),
          ],
        ),
      ),
    );
  }
}

class _IdeasFeedTab extends ConsumerWidget {
  const _IdeasFeedTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsyncValue = ref.watch(ideasStreamProvider);

    return ideasAsyncValue.when(
      data: (ideas) {
        if (ideas.isEmpty) {
          return const Center(child: Text('Aún no hay ideas globales.'));
        }
        return ListView.builder(
          itemCount: ideas.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return IdeaCard(idea: ideas[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class _DoodlesFeedTab extends ConsumerWidget {
  const _DoodlesFeedTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doodlesAsyncValue = ref.watch(doodlesStreamProvider);

    return doodlesAsyncValue.when(
      data: (doodles) {
        if (doodles.isEmpty) {
          return const Center(child: Text('Sé el primero en hacer un doodle.'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75, // Proporción de tarjeta 3:4 asegurada
          ),
          itemCount: doodles.length,
          itemBuilder: (context, index) {
            return DoodleCard(doodle: doodles[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class _ArtworksFeedTab extends StatelessWidget {
  const _ArtworksFeedTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Artworks: Próximamente (Iteración 4)',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
