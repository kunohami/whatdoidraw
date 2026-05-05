import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/core/providers/locale_provider.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';

/// Pantalla de ajustes de la aplicación.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(appLocaleProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.languageSetting),
            trailing: DropdownButton<String>(
              value: currentLocale.languageCode,
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
        ],
      ),
    );
  }
}
