import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/features/content_creation/viewmodels/create_idea_viewmodel.dart';
import 'package:whatdoidraw/shared/widgets/tag_input_field.dart';

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

    try {
      await ref
          .read(createIdeaControllerProvider.notifier)
          .submitIdea(_controller.text, _tags, _selectedLanguage);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Idea publicada exitosamente!')),
        );
        _controller.clear();
        setState(() => _tags = []);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createIdeaControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('💡 Nueva Idea'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '¿Qué te gustaría que alguien dibujara hoy?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                maxLines: 5,
                maxLength: 300,
                decoration: InputDecoration(
                  hintText: 'Ej: Un gato astronauta bebiendo café...',
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
                segments: const [
                  ButtonSegment(value: 'en', label: Text('English')),
                  ButtonSegment(value: 'es', label: Text('Español')),
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
                    : const Text('Enviar Idea', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
