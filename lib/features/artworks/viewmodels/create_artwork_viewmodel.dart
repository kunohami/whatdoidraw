import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:whatdoidraw/features/artworks/repositories/artworks_repository.dart';
import 'package:whatdoidraw/features/artworks/services/artwork_link_service.dart';
import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';

part 'create_artwork_viewmodel.g.dart';

class CreateArtworkState {
  final bool isLoading;
  final String? error;
  final ArtworkPreview? preview;

  const CreateArtworkState({this.isLoading = false, this.error, this.preview});

  CreateArtworkState copyWith({
    bool? isLoading,
    String? error,
    ArtworkPreview? preview,
  }) {
    return CreateArtworkState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      preview: preview ?? this.preview,
    );
  }
}

@riverpod
class CreateArtworkViewModel extends _$CreateArtworkViewModel {
  @override
  CreateArtworkState build() {
    return const CreateArtworkState();
  }

  Future<void> loadPreview(String url) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final service = ref.read(artworkLinkServiceProvider.notifier);
      final preview = await service.getPreview(url);

      if (preview == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'No se pudo obtener la vista previa del enlace.',
        );
      } else {
        state = state.copyWith(isLoading: false, preview: preview);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> publishArtwork({
    required String url,
    String? ideaId,
    String? doodleId,
    List<String> tags = const [],
  }) async {
    if (state.preview == null) {
      state = state.copyWith(error: 'Debes cargar la vista previa primero.');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final userId = ref.read(authControllerProvider).value?.id;
      if (userId == null) throw Exception('Usuario no autenticado');

      final artwork = ArtworkModel(
        id: const Uuid()
            .v4(), // Esto se ignorará en el repository si se remueve, pero el modelo requiere id.
        userId: userId,
        ideaId: ideaId,
        doodleId: doodleId,
        previewUrl: state.preview!.thumbnailUrl,
        externalLink: url,
        tags: tags,
      );

      await ref.read(artworksRepositoryProvider).createArtwork(artwork);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al publicar: ${e.toString()}',
      );
      return false;
    }
  }

  void clearPreview() {
    state = const CreateArtworkState();
  }
}
