// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doodle_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DoodleDetailNotifier)
final doodleDetailProvider = DoodleDetailNotifierFamily._();

final class DoodleDetailNotifierProvider
    extends $NotifierProvider<DoodleDetailNotifier, DoodleDetailState> {
  DoodleDetailNotifierProvider._({
    required DoodleDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'doodleDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$doodleDetailNotifierHash();

  @override
  String toString() {
    return r'doodleDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DoodleDetailNotifier create() => DoodleDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DoodleDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoodleDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DoodleDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$doodleDetailNotifierHash() =>
    r'82aa9003f3083326753ef709bcf15e98103149ee';

final class DoodleDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DoodleDetailNotifier,
          DoodleDetailState,
          DoodleDetailState,
          DoodleDetailState,
          String
        > {
  DoodleDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'doodleDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DoodleDetailNotifierProvider call(String doodleId) =>
      DoodleDetailNotifierProvider._(argument: doodleId, from: this);

  @override
  String toString() => r'doodleDetailProvider';
}

abstract class _$DoodleDetailNotifier extends $Notifier<DoodleDetailState> {
  late final _$args = ref.$arg as String;
  String get doodleId => _$args;

  DoodleDetailState build(String doodleId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DoodleDetailState, DoodleDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DoodleDetailState, DoodleDetailState>,
              DoodleDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
