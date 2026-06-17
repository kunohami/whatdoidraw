import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:whatdoidraw/features/profile/views/screens/select_avatar_doodle_screen.dart';
import 'package:whatdoidraw/features/profile/views/screens/settings_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/user_model.dart';
import 'package:whatdoidraw/shared/widgets/artwork_card.dart';
import 'package:whatdoidraw/shared/widgets/doodle_avatar.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';

/// Pantalla principal del perfil de usuario (propio o de terceros).
///
/// Muestra los detalles del usuario en la parte superior (Avatar, Nombre, Biografía)
/// y facilita la navegación entre sus historiales mediante un [DefaultTabController].
class ProfileScreen extends ConsumerStatefulWidget {
  final String? userId;

  const ProfileScreen({super.key, this.userId});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();
  bool _isSearchLoading = false;
  bool _isHeaderCollapsed = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    final username = query.trim();
    if (username.isEmpty) return;

    setState(() {
      _isSearchLoading = true;
    });

    try {
      final user = await ref
          .read(profileServiceProvider)
          .getUserByUsername(username);
      if (mounted) {
        setState(() {
          _isSearchLoading = false;
        });

        if (user != null) {
          setState(() {
            _isSearching = false;
            _searchController.clear();
          });
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(userId: user.id),
            ),
          );
        } else {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(l10n.profileSearchUserNotFound(username)),
                  ),
                ],
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSearchLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Error: $e')),
              ],
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserSession = ref.watch(authControllerProvider).value;
    final targetUserId = widget.userId ?? currentUserSession?.id;
    final isOwnProfile =
        targetUserId == null || targetUserId == currentUserSession?.id;
    final l10n = AppLocalizations.of(context)!;

    if (targetUserId == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.profileTitle), centerTitle: true),
        body: Center(child: Text(l10n.profileErrorLoading)),
      );
    }

    final profileAsync = ref.watch(userProfileProvider(targetUserId));

    return Scaffold(
      appBar: AppBar(
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                  });
                },
              )
            : (isOwnProfile
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isSearching = true;
                        });
                      },
                      icon: const Icon(Icons.search),
                      tooltip: l10n.profileTooltipSearch,
                    )
                  : null),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: l10n.profileSearchHint,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                ),
                onSubmitted: _performSearch,
              )
            : profileAsync.when(
                data: (profile) => Text(
                  isOwnProfile
                      ? l10n.profileTitle
                      : l10n.profileOf(profile.username),
                ),
                loading: () => Text(l10n.profileTitle),
                error: (_, _) => Text(l10n.profileTitle),
              ),
        centerTitle: !_isSearching,
        actions: _isSearching
            ? [
                if (_isSearchLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                else ...[
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _performSearch(_searchController.text),
                    tooltip: l10n.profileTooltipSearchAction,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      if (_searchController.text.isNotEmpty) {
                        _searchController.clear();
                      } else {
                        setState(() {
                          _isSearching = false;
                        });
                      }
                    },
                  ),
                ],
              ]
            : [
                if (!isOwnProfile)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                    icon: const Icon(Icons.search),
                    tooltip: l10n.profileTooltipSearch,
                  ),
                if (isOwnProfile) ...[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings),
                    tooltip: l10n.profileTooltipSettings,
                  ),
                ],
              ],
      ),
      body: profileAsync.when(
        data: (profile) {
          return DefaultTabController(
            length: 3,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  final delta = notification.scrollDelta ?? 0;
                  if (delta > 15 && !_isHeaderCollapsed) {
                    setState(() {
                      _isHeaderCollapsed = true;
                    });
                  }
                }
                return false;
              },
              child: Column(
                children: [
                  // Header del Perfil
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: _isHeaderCollapsed ? 12.0 : 20.0,
                    ),
                    child: Column(
                      children: [
                        // Colapsable: Imagen de perfil
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: _isHeaderCollapsed
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: _isHeaderCollapsed ? 0.0 : 1.0,
                                    child: GestureDetector(
                                      onTap: isOwnProfile
                                          ? () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SelectAvatarDoodleScreen(),
                                                ),
                                              );
                                            }
                                          : null,
                                      child: DoodleAvatar(
                                        radius: 50,
                                        avatarUrl: profile.avatarUrl,
                                      ),
                                    ),
                                  ),
                                ),
                        ),

                        // Siempre visible: Username con detector de deslizamiento para volver a expandir
                        GestureDetector(
                          onVerticalDragUpdate: (details) {
                            if (details.delta.dy > 3) {
                              if (_isHeaderCollapsed) {
                                setState(() {
                                  _isHeaderCollapsed = false;
                                });
                              }
                            }
                          },
                          child: MouseRegion(
                            cursor: _isHeaderCollapsed
                                ? SystemMouseCursors.click
                                : MouseCursor.defer,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: _isHeaderCollapsed ? 8 : 0,
                              ),
                              decoration: BoxDecoration(
                                color: _isHeaderCollapsed
                                    ? Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer
                                          .withValues(alpha: 0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: _isHeaderCollapsed
                                    ? Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withValues(alpha: 0.3),
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    profile.username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: _isHeaderCollapsed
                                              ? 18
                                              : 24,
                                        ),
                                  ),
                                  if (_isHeaderCollapsed) ...[
                                    const SizedBox(height: 2),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 12,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          l10n.profileExpandHint,
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Colapsable: Badges y Bio
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: _isHeaderCollapsed
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: _isHeaderCollapsed ? 0.0 : 1.0,
                                    child: Column(
                                      children: [
                                        // Badges
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (profile.isArtist)
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  top: 8,
                                                  right: 8,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Text(
                                                  l10n.profileVerifiedArtist,
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            if (!isOwnProfile)
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  top: 8,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.secondary,
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.tertiary,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(
                                                      Icons.explore_outlined,
                                                      color: Colors.white,
                                                      size: 12,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      l10n.profileVisitorMode,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),

                                        const SizedBox(height: 12),

                                        // Biografía / Mensaje Corto
                                        _buildBioSection(
                                          context,
                                          ref,
                                          profile,
                                          isOwnProfile,
                                          targetUserId,
                                          l10n,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  // Tabs
                  TabBar(
                    tabs: [
                      Tab(
                        icon: const Icon(Icons.lightbulb_outline),
                        text: l10n.tabIdeas,
                      ),
                      Tab(icon: const Icon(Icons.brush), text: l10n.tabDoodles),
                      Tab(
                        icon: const Icon(Icons.palette),
                        text: l10n.tabArtworks,
                      ),
                    ],
                  ),
                  // Tab Views
                  Expanded(
                    child: TabBarView(
                      children: [
                        _UserIdeasTab(
                          userId: targetUserId,
                          isOwnProfile: isOwnProfile,
                        ),
                        _UserDoodlesTab(
                          userId: targetUserId,
                          isOwnProfile: isOwnProfile,
                        ),
                        _UserArtworksTab(
                          userId: targetUserId,
                          isOwnProfile: isOwnProfile,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Error: $error")),
      ),
    );
  }

  Widget _buildBioSection(
    BuildContext context,
    WidgetRef ref,
    UserModel profile,
    bool isOwnProfile,
    String targetUserId,
    AppLocalizations l10n,
  ) {
    final bioText = profile.shortMessage;
    final hasBio = bioText != null && bioText.trim().isNotEmpty;

    if (isOwnProfile) {
      return GestureDetector(
        onTap: () =>
            _showEditBioDialog(context, ref, targetUserId, bioText, l10n),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            constraints: const BoxConstraints(maxWidth: 320),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    hasBio ? bioText : l10n.profileBioHint,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: hasBio ? FontStyle.italic : FontStyle.normal,
                      color: hasBio
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  hasBio ? Icons.edit_outlined : Icons.add_comment_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      if (!hasBio) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: const BoxConstraints(maxWidth: 320),
        child: Text(
          bioText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      );
    }
  }

  void _showEditBioDialog(
    BuildContext context,
    WidgetRef ref,
    String userId,
    String? currentBio,
    AppLocalizations l10n,
  ) {
    final controller = TextEditingController(text: currentBio);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.profileBioLabel),
          content: TextField(
            controller: controller,
            maxLength: 150,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: l10n.profileBioHint,
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.profileBioCancel),
            ),
            FilledButton(
              onPressed: () async {
                final newBio = controller.text.trim();
                Navigator.pop(context);
                try {
                  await ref
                      .read(profileServiceProvider)
                      .updateShortMessage(userId, newBio);
                  ref.invalidate(userProfileProvider(userId));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.profileBioUpdateSuccess)),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
              child: Text(l10n.profileBioSave),
            ),
          ],
        );
      },
    );
  }
}

/// Pestaña interna que gestiona y renderiza el historial de Ideas.
class _UserIdeasTab extends ConsumerWidget {
  final String userId;
  final bool isOwnProfile;

  const _UserIdeasTab({required this.userId, required this.isOwnProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsync = ref.watch(userIdeasProvider(userId));
    final l10n = AppLocalizations.of(context)!;

    return ideasAsync.when(
      data: (ideas) {
        if (ideas.isEmpty) {
          return Center(
            child: Text(
              isOwnProfile ? l10n.profileNoIdeas : l10n.otherProfileNoIdeas,
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ideas.length,
          itemBuilder: (context, index) {
            return IdeaCard(idea: ideas[index], showDrawButton: false);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text("Error: $error")),
    );
  }
}

/// Pestaña interna dedicada al historial de Doodles.
class _UserDoodlesTab extends ConsumerWidget {
  final String userId;
  final bool isOwnProfile;

  const _UserDoodlesTab({required this.userId, required this.isOwnProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doodlesAsync = ref.watch(userDoodlesProvider(userId));
    final l10n = AppLocalizations.of(context)!;

    return doodlesAsync.when(
      data: (doodles) {
        if (doodles.isEmpty) {
          return Center(
            child: Text(
              isOwnProfile ? l10n.profileNoDoodles : l10n.otherProfileNoDoodles,
              textAlign: TextAlign.center,
            ),
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
  final String userId;
  final bool isOwnProfile;

  const _UserArtworksTab({required this.userId, required this.isOwnProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artworksAsync = ref.watch(userArtworksProvider(userId));
    final l10n = AppLocalizations.of(context)!;

    return artworksAsync.when(
      data: (artworks) {
        if (artworks.isEmpty) {
          return Center(
            child: Text(
              isOwnProfile
                  ? l10n.profileNoArtworks
                  : l10n.otherProfileNoArtworks,
              textAlign: TextAlign.center,
            ),
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
