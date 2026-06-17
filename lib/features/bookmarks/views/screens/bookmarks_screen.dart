import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/bookmarks/viewmodels/bookmark_viewmodel.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.creationHubBookmarks),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.lightbulb_outline),
                text: l10n.tabIdeas,
              ),
              Tab(icon: const Icon(Icons.brush), text: l10n.tabDoodles),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_BookmarkedIdeasTab(), _BookmarkedDoodlesTab()],
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
    final l10n = AppLocalizations.of(context)!;

    return ideasAsync.when(
      data: (ideas) {
        if (ideas.isEmpty) {
          return Center(child: Text(l10n.bookmarksNoIdeas));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ideas.length,
          itemBuilder: (context, index) {
            return IdeaCard(idea: ideas[index], showDrawButton: true);
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
    final l10n = AppLocalizations.of(context)!;

    return doodlesAsync.when(
      data: (doodles) {
        if (doodles.isEmpty) {
          return Center(child: Text(l10n.bookmarksNoDoodles));
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
