// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArtworkDetailNotifier)
final artworkDetailProvider = ArtworkDetailNotifierFamily._();

final class ArtworkDetailNotifierProvider
    extends $NotifierProvider<ArtworkDetailNotifier, ArtworkDetailState> {
  ArtworkDetailNotifierProvider._({
    required ArtworkDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'artworkDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$artworkDetailNotifierHash();

  @override
  String toString() {
    return r'artworkDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArtworkDetailNotifier create() => ArtworkDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArtworkDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArtworkDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ArtworkDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$artworkDetailNotifierHash() =>
    r'e581cc9c005f3350de158ce31fb138ad3ca42e18';

final class ArtworkDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ArtworkDetailNotifier,
          ArtworkDetailState,
          ArtworkDetailState,
          ArtworkDetailState,
          String
        > {
  ArtworkDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'artworkDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArtworkDetailNotifierProvider call(String artworkId) =>
      ArtworkDetailNotifierProvider._(argument: artworkId, from: this);

  @override
  String toString() => r'artworkDetailProvider';
}

abstract class _$ArtworkDetailNotifier extends $Notifier<ArtworkDetailState> {
  late final _$args = ref.$arg as String;
  String get artworkId => _$args;

  ArtworkDetailState build(String artworkId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ArtworkDetailState, ArtworkDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ArtworkDetailState, ArtworkDetailState>,
              ArtworkDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
