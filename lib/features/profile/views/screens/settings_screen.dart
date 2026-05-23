import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/core/providers/locale_provider.dart';
import 'package:whatdoidraw/features/notifications/viewmodels/notifications_provider.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/user_model.dart';
import 'package:whatdoidraw/shared/widgets/tutorial_overlay.dart';

/// Pantalla de ajustes de la aplicación.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _editUsername(BuildContext context, WidgetRef ref, UserModel user) {
    final lastUpdated = user.usernameUpdatedAt;
    if (lastUpdated != null) {
      final diff = DateTime.now().difference(lastUpdated.toLocal());
      if (diff < const Duration(days: 1)) {
        final remaining = const Duration(days: 1) - diff;
        final hours = remaining.inHours;
        final minutes = remaining.inMinutes % 60;
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.settingsUsernameCooldownError(
                      hours.toString(),
                      minutes.toString(),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.amber[800],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        return;
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _EditUsernameDialog(user: user),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(appLocaleProvider);
    final l10n = AppLocalizations.of(context)!;
    final profileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(l10n.profileErrorLoading)),
        data: (user) {
          if (user == null) return const SizedBox();

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            children: [
              ListTile(
                leading: Icon(
                  Icons.alternate_email,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(l10n.settingsUsernameTitle),
                subtitle: Text('@${user.username}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _editUsername(context, ref, user),
              ),
              ListTile(
                leading: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Cuenta de correo'),
                subtitle: Text(
                  Supabase.instance.client.auth.currentUser?.email ??
                      'No disponible',
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(l10n.languageSetting),
                trailing: DropdownButton<String>(
                  value: currentLocale.languageCode,
                  dropdownColor: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  underline: const SizedBox(),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(l10n.languageEnglish),
                    ),
                    DropdownMenuItem(
                      value: 'es',
                      child: Text(l10n.languageSpanish),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      ref
                          .read(appLocaleProvider.notifier)
                          .setLocale(Locale(newValue));
                    }
                  },
                ),
              ),
              const Divider(),
              SwitchListTile(
                secondary: Icon(
                  Icons.notifications_active,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Notificaciones en el móvil (Push)'),
                value: user.pushNotifications,
                onChanged: (val) async {
                  if (val) {
                    // Mostrar un diálogo de carga transparente no bloqueante
                    unawaited(
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const PopScope(
                          canPop: false,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    );

                    try {
                      await ref
                          .read(notificationsProvider.notifier)
                          .requestPushPermissionsAndSaveToken(user.id);
                    } finally {
                      if (context.mounted) {
                        Navigator.pop(context); // Cerrar el diálogo de carga
                      }
                    }
                  } else {
                    await ref
                        .read(profileServiceProvider)
                        .updatePushSettings(
                          user.id,
                          hasSeenPushPrompt: true,
                          pushNotifications: false,
                        );
                  }
                  ref.invalidate(userProfileProvider(user.id));
                },
              ),
              SwitchListTile(
                secondary: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Notificaciones por Correo'),
                value: user.emailNotifications,
                onChanged: (val) async {
                  await ref
                      .read(profileServiceProvider)
                      .updateNotificationPreferences(
                        user.id,
                        emailNotifications: val,
                        pushNotifications: user.pushNotifications,
                      );
                  ref.invalidate(userProfileProvider(user.id));
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(l10n.settingsTutorialReplay),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                  // Re-show the general tutorial
                  TutorialOverlay.showGeneral(context, l10n);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EditUsernameDialog extends ConsumerStatefulWidget {
  final UserModel user;
  const _EditUsernameDialog({required this.user});

  @override
  ConsumerState<_EditUsernameDialog> createState() =>
      _EditUsernameDialogState();
}

class _EditUsernameDialogState extends ConsumerState<_EditUsernameDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  bool _isLoading = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.user.username);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _errorText = null;
    });

    if (!_formKey.currentState!.validate()) return;

    final newUsername = _controller.text.trim();
    if (newUsername.toLowerCase() == widget.user.username.toLowerCase()) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final l10n = AppLocalizations.of(context)!;
    final profileService = ref.read(profileServiceProvider);

    try {
      final taken = await profileService.isUsernameTaken(
        newUsername,
        widget.user.id,
      );
      if (taken) {
        setState(() {
          _errorText = l10n.settingsUsernameAlreadyTaken(newUsername);
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.settingsUsernameConfirmTitle),
          content: Text(l10n.settingsUsernameConfirmMessage(newUsername)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.profileBioCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(l10n.btnConfirm),
            ),
          ],
        ),
      );

      if (confirm == true) {
        if (!mounted) return;
        setState(() {
          _isLoading = true;
        });

        await profileService.updateUsername(widget.user.id, newUsername);

        ref.invalidate(currentUserProfileProvider);
        ref.invalidate(userProfileProvider(widget.user.id));

        if (!mounted) return;
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text(l10n.settingsUsernameSuccess)),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorText = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.settingsUsernameTitle),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: l10n.settingsUsernameTitle,
                prefixText: '@',
                errorText: _errorText,
                border: const OutlineInputBorder(),
              ),
              enabled: !_isLoading,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return l10n.settingsUsernameInvalid;
                }
                final reg = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
                if (!reg.hasMatch(val)) {
                  return l10n.settingsUsernameInvalid;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.profileBioCancel),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(l10n.btnSave),
        ),
      ],
    );
  }
}
