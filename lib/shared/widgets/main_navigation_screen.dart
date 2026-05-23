import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/core/providers/locale_provider.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/creation_hub_screen.dart';
import 'package:whatdoidraw/features/feed/views/screens/artwork_detail_screen.dart';
import 'package:whatdoidraw/features/feed/views/screens/doodle_detail_screen.dart';
import 'package:whatdoidraw/features/feed/views/screens/feed_screen.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/features/profile/views/screens/profile_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/widgets/tutorial_overlay.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    FeedScreen(),
    CreationHubScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkGeneralTutorial();
      _initializeFcmListeners();
    });
  }

  Future<void> _initializeFcmListeners() async {
    // 1. Manejar clic cuando la app está en segundo plano (background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
        'FCM Notification tapped (onMessageOpenedApp): ${message.data}',
      );
      _handleNotificationClick(message.data);
    });

    // 2. Manejar clic cuando la app estaba completamente CERRADA (terminated)
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      debugPrint(
        'FCM Notification tapped (getInitialMessage): ${initialMessage.data}',
      );
      await _handleNotificationClick(initialMessage.data);
    }
  }

  Future<void> _handleNotificationClick(Map<String, dynamic> data) async {
    final type = data['type'];
    final targetId = data['target_id'];
    if (type == null || targetId == null) {
      debugPrint('Notificación incompleta, faltan parámetros: $data');
      return;
    }

    final profileService = ref.read(profileServiceProvider);

    if (type == 'idea_used_for_doodle') {
      final doodle = await profileService.getDoodleById(targetId);
      if (doodle != null && mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DoodleDetailScreen(doodle: doodle)),
        );
      }
    } else if (type == 'idea_used_for_artwork' ||
        type == 'doodle_used_for_artwork') {
      final artwork = await profileService.getArtworkById(targetId);
      if (artwork != null && mounted) {
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
  }

  void _checkGeneralTutorial() {
    final prefs = ref.read(sharedPreferencesProvider);
    final hasSeen = prefs.getBool('hasSeenGeneralTutorial') ?? false;
    if (!hasSeen) {
      final l10n = AppLocalizations.of(context)!;
      TutorialOverlay.showGeneral(
        context,
        l10n,
        onComplete: () => prefs.setBool('hasSeenGeneralTutorial', true),
        onSkip: () => prefs.setBool('hasSeenGeneralTutorial', true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.explore_outlined),
            selectedIcon: const Icon(Icons.explore),
            label: l10n.navFeed,
          ),
          NavigationDestination(
            icon: const Icon(Icons.add_circle_outline),
            selectedIcon: const Icon(Icons.add_circle),
            label: l10n.navCreate,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
