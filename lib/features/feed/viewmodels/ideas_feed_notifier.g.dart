// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ideas_feed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ViewModel que gestiona el feed de Ideas con paginación, búsqueda y ordenación.
///
/// Patrón: el notifier acumula resultados (`_items`) y la UI reacciona a cada
/// cambio de estado. El usuario puede pedir más items explícitamente con
/// [loadMore] o resetear con [refresh].

@ProviderFor(IdeasFeedNotifier)
final ideasFeedProvider = IdeasFeedNotifierProvider._();

/// ViewModel que gestiona el feed de Ideas con paginación, búsqueda y ordenación.
///
/// Patrón: el notifier acumula resultados (`_items`) y la UI reacciona a cada
/// cambio de estado. El usuario puede pedir más items explícitamente con
/// [loadMore] o resetear con [refresh].
final class IdeasFeedNotifierProvider
    extends $NotifierProvider<IdeasFeedNotifier, IdeasFeedState> {
  /// ViewModel que gestiona el feed de Ideas con paginación, búsqueda y ordenación.
  ///
  /// Patrón: el notifier acumula resultados (`_items`) y la UI reacciona a cada
  /// cambio de estado. El usuario puede pedir más items explícitamente con
  /// [loadMore] o resetear con [refresh].
  IdeasFeedNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ideasFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ideasFeedNotifierHash();

  @$internal
  @override
  IdeasFeedNotifier create() => IdeasFeedNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IdeasFeedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IdeasFeedState>(value),
    );
  }
}

String _$ideasFeedNotifierHash() => r'65ec066785621d14116a9448b137bbf8433b6979';

/// ViewModel que gestiona el feed de Ideas con paginación, búsqueda y ordenación.
///
/// Patrón: el notifier acumula resultados (`_items`) y la UI reacciona a cada
/// cambio de estado. El usuario puede pedir más items explícitamente con
/// [loadMore] o resetear con [refresh].

abstract class _$IdeasFeedNotifier extends $Notifier<IdeasFeedState> {
  IdeasFeedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<IdeasFeedState, IdeasFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IdeasFeedState, IdeasFeedState>,
              IdeasFeedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
