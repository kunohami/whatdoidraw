// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doodles_feed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ViewModel que gestiona el feed de Doodles con paginación y filtros por tags.

@ProviderFor(DoodlesFeedNotifier)
final doodlesFeedProvider = DoodlesFeedNotifierProvider._();

/// ViewModel que gestiona el feed de Doodles con paginación y filtros por tags.
final class DoodlesFeedNotifierProvider
    extends $NotifierProvider<DoodlesFeedNotifier, DoodlesFeedState> {
  /// ViewModel que gestiona el feed de Doodles con paginación y filtros por tags.
  DoodlesFeedNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doodlesFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doodlesFeedNotifierHash();

  @$internal
  @override
  DoodlesFeedNotifier create() => DoodlesFeedNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DoodlesFeedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoodlesFeedState>(value),
    );
  }
}

String _$doodlesFeedNotifierHash() =>
    r'a7424e8ae2ecb92ca7e3fdfcfe2eb550ac6edd17';

/// ViewModel que gestiona el feed de Doodles con paginación y filtros por tags.

abstract class _$DoodlesFeedNotifier extends $Notifier<DoodlesFeedState> {
  DoodlesFeedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DoodlesFeedState, DoodlesFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DoodlesFeedState, DoodlesFeedState>,
              DoodlesFeedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
