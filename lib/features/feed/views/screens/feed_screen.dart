import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/features/feed/viewmodels/feed_viewmodel.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsyncValue = ref.watch(ideasStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('💡 Últimas Ideas'), centerTitle: true),
      body: ideasAsyncValue.when(
        data: (ideas) {
          if (ideas.isEmpty) {
            return const Center(
              child: Text('Sé el primero en aportar una idea.'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              // El stream se actualiza automáticamente
            },
            child: ListView.builder(
              itemCount: ideas.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final idea = ideas[index];
                return IdeaCard(idea: idea);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
