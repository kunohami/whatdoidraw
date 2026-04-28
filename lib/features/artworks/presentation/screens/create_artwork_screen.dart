import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/artworks/viewmodels/create_artwork_viewmodel.dart';
import 'package:whatdoidraw/features/artworks/services/deviantart_service.dart';

class CreateArtworkScreen extends ConsumerStatefulWidget {
  final String? ideaId;
  final String? doodleId;

  const CreateArtworkScreen({
    super.key,
    this.ideaId,
    this.doodleId,
  });

  @override
  ConsumerState<CreateArtworkScreen> createState() => _CreateArtworkScreenState();
}

class _CreateArtworkScreenState extends ConsumerState<CreateArtworkScreen> {
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _loadPreview() {
    if (_formKey.currentState!.validate()) {
      ref.read(createArtworkViewModelProvider.notifier).loadPreview(_urlController.text);
    }
  }

  void _publish() async {
    final success = await ref.read(createArtworkViewModelProvider.notifier).publishArtwork(
      url: _urlController.text,
      ideaId: widget.ideaId,
      doodleId: widget.doodleId,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Artwork publicado correctamente!')),
      );
      Navigator.of(context).pop(); // Volver atrás
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createArtworkViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicar Artwork'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enlaza tu obra final de DeviantArt para compartirla con la comunidad.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'URL de DeviantArt',
                  hintText: 'https://www.deviantart.com/usuario/art/...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce una URL';
                  }
                  if (!ref.read(deviantArtServiceProvider).isValidDeviantArtUrl(value)) {
                    return 'Debe ser un enlace válido de DeviantArt';
                  }
                  return null;
                },
                onChanged: (_) {
                  // Si el usuario cambia la URL, limpiamos la preview.
                  if (state.preview != null) {
                    ref.read(createArtworkViewModelProvider.notifier).clearPreview();
                  }
                },
              ),
              const SizedBox(height: 16),
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
                            child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(state.preview!.title),
                        subtitle: Text('por ${state.preview!.authorName}'),
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
              ],
            ],
          ),
        ),
      ),
    );
  }
}
