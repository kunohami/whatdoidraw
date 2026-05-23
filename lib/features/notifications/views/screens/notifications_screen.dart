import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/notifications/viewmodels/notifications_provider.dart';
import 'package:whatdoidraw/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
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
    final profileOpt = ref.read(currentUserProfileProvider);
    profileOpt.whenData((user) async {
      if (user != null && !user.hasSeenPushPrompt) {
        final accept = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Notificaciones Push'),
            content: const Text('¿Quieres recibir notificaciones en tu móvil cuando alguien use tus ideas o doodles?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Ahora no'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Sí, activar'),
              ),
            ],
          ),
        );
        if (accept != null) {
          await ref.read(notificationsProvider.notifier).markPushPromptAsSeen(user.id, accept);
          ref.invalidate(currentUserProfileProvider);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        centerTitle: true,
      ),
      body: notificationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text('No tienes notificaciones aún.'));
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: notif.isRead ? Colors.grey[200] : Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    notif.type == 'idea_used' ? Icons.lightbulb : Icons.brush,
                    color: notif.isRead ? Colors.grey : Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  notif.type == 'idea_used' 
                    ? '¡Alguien ha usado tu idea!' 
                    : '¡Alguien ha usado tu doodle!',
                  style: TextStyle(fontWeight: notif.isRead ? FontWeight.normal : FontWeight.bold),
                ),
                subtitle: const Text('Toca para ver la creación.'),
                onTap: () {
                  ref.read(notificationsProvider.notifier).markAsRead(notif.id);
                  // Navegar a la vista de la creación usando target_id
                  // En un caso real: Navigator.push(...) al detail screen
                },
              );
            },
          );
        },
      ),
    );
  }
}

