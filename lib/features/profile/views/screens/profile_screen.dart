import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:whatdoidraw/features/profile/views/screens/settings_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/widgets/artwork_card.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';

/// Pantalla principal del perfil de usuario autenticado.
///
/// Muestra los detalles del usuario en la parte superior (Avatar, Nombre)
/// y facilita la navegación entre sus historiales mediante un [DefaultTabController].
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentUserProfileProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            icon: const Icon(Icons.settings),
            tooltip: l10n.profileTooltipSettings,
          ),
          IconButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
            icon: const Icon(Icons.logout),
            tooltip: l10n.profileTooltipLogout,
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return Center(child: Text(l10n.profileErrorLoading));
          }

          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                // Header del Perfil
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        backgroundImage: profile.avatarUrl != null
                            ? NetworkImage(profile.avatarUrl!)
                            : null,
                        child: profile.avatarUrl == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.username,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (profile.isArtist)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            l10n.profileVerifiedArtist,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                // Tabs
                const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.lightbulb_outline), text: "Ideas"),
                    Tab(icon: Icon(Icons.brush), text: "Doodles"),
                    Tab(icon: Icon(Icons.palette), text: "Artworks"),
                  ],
                ),
                // Tab Views
                const Expanded(
                  child: TabBarView(
                    children: [
                      _UserIdeasTab(),
                      _UserDoodlesTab(),
                      _UserArtworksTab(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Error: $error")),
      ),
    );
  }
}

/// Pestaña interna que gestiona y renderiza el historial de Ideas.
///
/// Consume temporalmente el Provider de la historia y despliega
/// una lista construida con [IdeaCard].
class _UserIdeasTab extends ConsumerWidget {
  const _UserIdeasTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsync = ref.watch(currentUserIdeasProvider);
    final l10n = AppLocalizations.of(context)!;

    return ideasAsync.when(
      data: (ideas) {
        if (ideas.isEmpty) {
          return Center(child: Text(l10n.profileNoIdeas));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ideas.length,
          itemBuilder: (context, index) {
            return IdeaCard(
              idea: ideas[index],
              showDrawButton:
                  false, // Opcional, pero en tu perfil quizás sólo quieres verlas
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text("Error: $error")),
    );
  }
}

/// Pestaña interna dedicada al historial de Doodles.
///
/// Muestra las miniaturas de los dibujos generándolos en tiempo real.
/// Se usa [FittedBox] sobre un canvas fijo para escalar los puntos vectoriales
/// guardados originalmemente, logrando visualizaciones reducidas de alta calidad
/// sin penalizaciones de rendimiento.
class _UserDoodlesTab extends ConsumerWidget {
  const _UserDoodlesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doodlesAsync = ref.watch(currentUserDoodlesProvider);
    final l10n = AppLocalizations.of(context)!;

    return doodlesAsync.when(
      data: (doodles) {
        if (doodles.isEmpty) {
          return Center(
            child: Text(l10n.profileNoDoodles),
          );
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

/// Pestaña interna dedicada al historial de Artworks.
class _UserArtworksTab extends ConsumerWidget {
  const _UserArtworksTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artworksAsync = ref.watch(currentUserArtworksProvider);
    final l10n = AppLocalizations.of(context)!;

    return artworksAsync.when(
      data: (artworks) {
        if (artworks.isEmpty) {
          return Center(
            child: Text(l10n.profileNoArtworks),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: artworks.length,
          itemBuilder: (context, index) {
            return ArtworkCard(artwork: artworks[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text("Error: $error")),
    );
  }
}
