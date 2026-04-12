import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'feed_provider.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsyncValue = ref.watch(ideasStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('💡 Últimas Ideas'),
        centerTitle: true,
      ),
      body: ideasAsyncValue.when(
        data: (ideas) {
          if (ideas.isEmpty) {
            return const Center(child: Text('Sé el primero en aportar una idea.'));
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
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          idea.content,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Una idea de un soñador', 
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.draw_outlined),
                              onPressed: () {},
                              tooltip: 'Dibujar esta idea',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
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
