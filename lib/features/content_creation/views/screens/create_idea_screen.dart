import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/features/content_creation/viewmodels/create_idea_viewmodel.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/widgets/tag_input_field.dart';
import 'package:whatdoidraw/shared/widgets/tutorial_overlay.dart';

class CreateIdeaScreen extends ConsumerStatefulWidget {
  const CreateIdeaScreen({super.key});

  @override
  ConsumerState<CreateIdeaScreen> createState() => _CreateIdeaScreenState();
}

class _CreateIdeaScreenState extends ConsumerState<CreateIdeaScreen> {
  final _controller = TextEditingController();
  List<String> _tags = [];
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    final locale = PlatformDispatcher.instance.locale.languageCode;
    _selectedLanguage = locale.startsWith('es') ? 'es' : 'en';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_controller.text.trim().isEmpty) return;
    final l10n = AppLocalizations.of(context)!;

    try {
      await ref
          .read(createIdeaControllerProvider.notifier)
          .submitIdea(_controller.text, _tags, _selectedLanguage);
      if (mounted) {
        _controller.clear();
        setState(() => _tags = []);

        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.createIdeaSuccessDialogTitle),
            content: Text(l10n.createIdeaSuccessDialogContent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                child: Text(l10n.btnExit),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(l10n.btnWriteAnother),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.genericError(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createIdeaControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('💡 ${l10n.creationHubNewIdea}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: l10n.tooltipHelp,
            onPressed: () {
              TutorialOverlay.showCreateIdeaInfo(context, l10n);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.createIdeaPromptQuestion,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                maxLines: 5,
                maxLength: 300,
                decoration: InputDecoration(
                  hintText: l10n.createIdeaPromptHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                ),
                enabled: !isLoading,
              ),
              const SizedBox(height: 16),
              TagInputField(
                onTagsChanged: (tags) => setState(() => _tags = tags),
                initialTags: _tags,
              ),
              const SizedBox(height: 16),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'en', label: Text(l10n.languageEnglish)),
                  ButtonSegment(value: 'es', label: Text(l10n.languageSpanish)),
                ],
                selected: {_selectedLanguage},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    _selectedLanguage = newSelection.first;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        l10n.createIdeaSubmitBtn,
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
