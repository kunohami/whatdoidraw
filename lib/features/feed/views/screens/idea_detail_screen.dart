import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/feed/viewmodels/idea_detail_notifier.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/widgets/artwork_card.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';

class IdeaDetailScreen extends ConsumerWidget {
  final String ideaId;

  const IdeaDetailScreen({super.key, required this.ideaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ideaDetailProvider(ideaId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.ideaDetailTitle)),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(child: Text('Error: ${state.errorMessage}'))
          : state.idea == null
          ? Center(child: Text(l10n.feedNoIdeas))
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverToBoxAdapter(
                    child: IdeaCard(idea: state.idea!, showDrawButton: true),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      l10n.derivedCreationsTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                if (state.creations.isEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.palette_outlined,
                              size: 48,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              l10n.emptyIdeaCreationsTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.emptyIdeaCreationsSubtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final creation = state.creations[index];
                        if (creation is DoodleModel) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: SizedBox(
                              height: 300,
                              child: DoodleCard(doodle: creation),
                            ),
                          );
                        } else if (creation is ArtworkModel) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ArtworkCard(artwork: creation),
                          );
                        }
                        return const SizedBox.shrink();
                      }, childCount: state.creations.length),
                    ),
                  ),
              ],
            ),
    );
  }
}
