import 'package:flutter/material.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usaremos AppLocalizations para tener los textos traducidos
    // Por ahora pondremos un placeholder
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('You have no notifications yet.'),
      ),
    );
  }
}
