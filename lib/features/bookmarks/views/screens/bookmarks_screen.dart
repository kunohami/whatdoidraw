import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/bookmarks/viewmodels/bookmark_viewmodel.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guardados'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.lightbulb_outline), text: "Ideas"),
              Tab(icon: Icon(Icons.brush), text: "Doodles"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _BookmarkedIdeasTab(),
            _BookmarkedDoodlesTab(),
          ],
        ),
      ),
    );
  }
}

class _BookmarkedIdeasTab extends ConsumerWidget {
  const _BookmarkedIdeasTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsync = ref.watch(bookmarkedIdeasProvider);

    return ideasAsync.when(
      data: (ideas) {
        if (ideas.isEmpty) {
          return const Center(child: Text("No tienes ideas guardadas."));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ideas.length,
          itemBuilder: (context, index) {
            return IdeaCard(
              idea: ideas[index],
              showDrawButton: true,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text("Error: $error")),
    );
  }
}

class _BookmarkedDoodlesTab extends ConsumerWidget {
  const _BookmarkedDoodlesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doodlesAsync = ref.watch(bookmarkedDoodlesProvider);

    return doodlesAsync.when(
      data: (doodles) {
        if (doodles.isEmpty) {
          return const Center(child: Text("No tienes doodles guardados."));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: doodles.length,
          itemBuilder: (context, index) {
            return DoodleCard(doodle: doodles[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text("Error: $error")),
    );
  }
}
