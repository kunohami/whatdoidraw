import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/core/providers/locale_provider.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/creation_hub_screen.dart';
import 'package:whatdoidraw/features/feed/views/screens/feed_screen.dart';
import 'package:whatdoidraw/features/profile/views/screens/profile_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/widgets/tutorial_overlay.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() => _MainNavigationScreenState();
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
    });
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
