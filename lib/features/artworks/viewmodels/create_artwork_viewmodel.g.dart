// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_artwork_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateArtworkViewModel)
final createArtworkViewModelProvider = CreateArtworkViewModelProvider._();

final class CreateArtworkViewModelProvider
    extends $NotifierProvider<CreateArtworkViewModel, CreateArtworkState> {
  CreateArtworkViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createArtworkViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createArtworkViewModelHash();

  @$internal
  @override
  CreateArtworkViewModel create() => CreateArtworkViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateArtworkState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateArtworkState>(value),
    );
  }
}

String _$createArtworkViewModelHash() =>
    r'48112ffd835dab601b227d13ae03ddba84ce9ba0';

abstract class _$CreateArtworkViewModel extends $Notifier<CreateArtworkState> {
  CreateArtworkState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CreateArtworkState, CreateArtworkState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CreateArtworkState, CreateArtworkState>,
              CreateArtworkState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
