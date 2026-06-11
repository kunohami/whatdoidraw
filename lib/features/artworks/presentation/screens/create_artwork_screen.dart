import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/artworks/services/artwork_link_service.dart';
import 'package:whatdoidraw/features/artworks/viewmodels/create_artwork_viewmodel.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/widgets/moving_gradient_placeholder.dart';

class CreateArtworkScreen extends ConsumerStatefulWidget {
  final String? ideaId;
  final String? doodleId;
  final List<String> initialTags;

  const CreateArtworkScreen({
    super.key,
    this.ideaId,
    this.doodleId,
    this.initialTags = const [],
  });

  @override
  ConsumerState<CreateArtworkScreen> createState() =>
      _CreateArtworkScreenState();
}

class _CreateArtworkScreenState extends ConsumerState<CreateArtworkScreen> {
  final _urlController = TextEditingController();
  final _tagController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.initialTags);
  }

  @override
  void dispose() {
    _urlController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _loadPreview() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(createArtworkViewModelProvider.notifier)
          .loadPreview(_urlController.text);
    }
  }

  void _publish() async {
    final l10n = AppLocalizations.of(context)!;
    final success = await ref
        .read(createArtworkViewModelProvider.notifier)
        .publishArtwork(
          url: _urlController.text,
          ideaId: widget.ideaId,
          doodleId: widget.doodleId,
          tags: _tags,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.createArtworkSuccessSnackBar)),
      );
      Navigator.of(context).pop(); // Volver atrás
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createArtworkViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createArtworkTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.createArtworkInstruction,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: l10n.createArtworkUrlLabel,
                  hintText: l10n.createArtworkUrlHint,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.link),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.createArtworkUrlRequired;
                  }
                  if (!ref
                      .read(artworkLinkServiceProvider.notifier)
                      .isValidUrl(value)) {
                    return l10n.createArtworkUrlInvalid;
                  }
                  return null;
                },
                onChanged: (_) {
                  // Si el usuario cambia la URL, limpiamos la preview.
                  if (state.preview != null) {
                    ref
                        .read(createArtworkViewModelProvider.notifier)
                        .clearPreview();
                  }
                },
              ),
              const SizedBox(height: 24),
              Text(
                l10n.createArtworkTagsLabel,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () => _removeTag(tag),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tagController,
                      decoration: InputDecoration(
                        hintText: l10n.createArtworkTagAddHint,
                        border: const OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _addTag(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _addTag,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: state.isLoading ? null : _loadPreview,
                child: state.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.createArtworkLoadPreviewBtn),
              ),
              const SizedBox(height: 24),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (state.preview != null) ...[
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      if (state.preview!.thumbnailUrl.isNotEmpty)
                        Image.network(
                          state.preview!.thumbnailUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const MovingGradientPlaceholder(
                                height: 200,
                                icon: Icons.link_off,
                              ),
                        )
                      else
                        const MovingGradientPlaceholder(
                          height: 200,
                          icon: Icons.link,
                        ),
                      ListTile(
                        title: Text(state.preview!.title),
                        subtitle: Text(
                          l10n.createArtworkAuthorFormat(
                            state.preview!.authorName,
                            state.preview!.providerName,
                          ),
                        ),
                      ),
                      if (state.preview!.thumbnailUrl.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            l10n.createArtworkNoThumbnailNote,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: state.isLoading ? null : _publish,
                  icon: const Icon(Icons.publish),
                  label: Text(l10n.createArtworkTitle),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ), // Espacio extra para evitar la barra de navegación de Android
              ],
            ],
          ),
        ),
      ),
    );
  }
}
