// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doodle_detail_artworks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DoodleDetailArtworksNotifier)
final doodleDetailArtworksProvider = DoodleDetailArtworksNotifierFamily._();

final class DoodleDetailArtworksNotifierProvider
    extends
        $NotifierProvider<
          DoodleDetailArtworksNotifier,
          DoodleDetailArtworksState
        > {
  DoodleDetailArtworksNotifierProvider._({
    required DoodleDetailArtworksNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'doodleDetailArtworksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$doodleDetailArtworksNotifierHash();

  @override
  String toString() {
    return r'doodleDetailArtworksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DoodleDetailArtworksNotifier create() => DoodleDetailArtworksNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DoodleDetailArtworksState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoodleDetailArtworksState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DoodleDetailArtworksNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$doodleDetailArtworksNotifierHash() =>
    r'53873e61b94712b82c6a973eca34a77ba3e4fe62';

final class DoodleDetailArtworksNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DoodleDetailArtworksNotifier,
          DoodleDetailArtworksState,
          DoodleDetailArtworksState,
          DoodleDetailArtworksState,
          String
        > {
  DoodleDetailArtworksNotifierFamily._()
    : super(
        retry: null,
        name: r'doodleDetailArtworksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DoodleDetailArtworksNotifierProvider call(String doodleId) =>
      DoodleDetailArtworksNotifierProvider._(argument: doodleId, from: this);

  @override
  String toString() => r'doodleDetailArtworksProvider';
}

abstract class _$DoodleDetailArtworksNotifier
    extends $Notifier<DoodleDetailArtworksState> {
  late final _$args = ref.$arg as String;
  String get doodleId => _$args;

  DoodleDetailArtworksState build(String doodleId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<DoodleDetailArtworksState, DoodleDetailArtworksState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DoodleDetailArtworksState, DoodleDetailArtworksState>,
              DoodleDetailArtworksState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
