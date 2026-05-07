import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/artworks/services/artwork_link_service.dart';
import 'package:whatdoidraw/features/artworks/viewmodels/create_artwork_viewmodel.dart';

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
        const SnackBar(content: Text('¡Artwork publicado correctamente!')),
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

    return Scaffold(
      appBar: AppBar(title: const Text('Publicar Artwork')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enlaza tu obra final para compartirla. Si usas DeviantArt o Bluesky, se mostrará una miniatura automáticamente.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'URL del Artwork',
                  hintText: 'DeviantArt o Bluesky...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce una URL';
                  }
                  if (!ref
                      .read(artworkLinkServiceProvider.notifier)
                      .isValidUrl(value)) {
                    return 'Introduce una red social válida (Instagram, ArtStation, Cara, etc.)';
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
              const Text(
                'Etiquetas (Tags)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      decoration: const InputDecoration(
                        hintText: 'Añadir etiqueta...',
                        border: OutlineInputBorder(),
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
                    : const Text('Cargar Vista Previa'),
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
                      Image.network(
                        state.preview!.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(
                              height: 200,
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                      ),
                      ListTile(
                        title: Text(state.preview!.title),
                        subtitle: Text(
                          'por ${state.preview!.authorName} (${state.preview!.providerName})',
                        ),
                      ),
                      if (state.preview!.thumbnailUrl.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Nota: No hay miniatura disponible para esta red social. Se mostrará solo el enlace.',
                            style: TextStyle(
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
                  label: const Text('Publicar Artwork'),
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
