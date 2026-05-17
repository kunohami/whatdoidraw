// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LikeViewModel)
final likeViewModelProvider = LikeViewModelProvider._();

final class LikeViewModelProvider
    extends $NotifierProvider<LikeViewModel, void> {
  LikeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likeViewModelHash();

  @$internal
  @override
  LikeViewModel create() => LikeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$likeViewModelHash() => r'9dea40c2ff03a46962ba1ff1635902ad280d6fb8';

abstract class _$LikeViewModel extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
