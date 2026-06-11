import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/feed/views/screens/artwork_detail_screen.dart';
import 'package:whatdoidraw/features/feed/views/screens/doodle_detail_screen.dart';
import 'package:whatdoidraw/features/notifications/viewmodels/notifications_provider.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPushPrompt();
    });
  }

  Future<void> _checkPushPrompt() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final profileOpt = ref.read(currentUserProfileProvider);
    profileOpt.whenData((user) async {
      if (user != null && !user.hasSeenPushPrompt) {
        if (!mounted) return;
        final accept = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.notificationsPushDialogTitle),
            content: Text(l10n.notificationsPushDialogContent),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.notificationsPushDialogCancel),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l10n.notificationsPushDialogConfirm),
              ),
            ],
          ),
        );
        if (accept != null && mounted) {
          await ref
              .read(notificationsProvider.notifier)
              .markPushPromptAsSeen(user.id, accept);
          ref.invalidate(userProfileProvider(user.id));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notificationsTitle), centerTitle: true),
      body: notificationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(l10n.genericError(err.toString()))),
        data: (notifications) {
          if (notifications.isEmpty) {
            return Center(child: Text(l10n.notificationsEmpty));
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: notif.isRead
                      ? Colors.grey[200]
                      : Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    notif.type.contains('artwork')
                        ? Icons.art_track
                        : Icons.brush,
                    color: notif.isRead
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  notif.type == 'idea_used_for_doodle'
                      ? l10n.notifIdeaUsedForDoodle(notif.actor?.username ?? '')
                      : notif.type == 'idea_used_for_artwork'
                      ? l10n.notifIdeaUsedForArtwork(notif.actor?.username ?? '')
                      : l10n.notifDoodleUsedForArtwork(notif.actor?.username ?? ''),
                  style: TextStyle(
                    fontWeight: notif.isRead
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  await ref
                      .read(notificationsProvider.notifier)
                      .markAsRead(notif.id);
                  final profileService = ref.read(profileServiceProvider);

                  if (notif.type == 'idea_used_for_doodle') {
                    final doodle = await profileService.getDoodleById(
                      notif.targetId,
                    );
                    if (doodle != null && context.mounted) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DoodleDetailScreen(doodle: doodle),
                        ),
                      );
                    }
                  } else {
                    final artwork = await profileService.getArtworkById(
                      notif.targetId,
                    );
                    if (artwork != null && context.mounted) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArtworkDetailScreen(
                            artworkId: artwork.id,
                            initialArtwork: artwork,
                          ),
                        ),
                      );
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
