// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doodle_canvas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DoodleCanvas)
final doodleCanvasProvider = DoodleCanvasProvider._();

final class DoodleCanvasProvider
    extends $NotifierProvider<DoodleCanvas, List<StrokeModel>> {
  DoodleCanvasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doodleCanvasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doodleCanvasHash();

  @$internal
  @override
  DoodleCanvas create() => DoodleCanvas();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<StrokeModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<StrokeModel>>(value),
    );
  }
}

String _$doodleCanvasHash() => r'861146be06b2dc0e27ac19373cef420200d8d061';

abstract class _$DoodleCanvas extends $Notifier<List<StrokeModel>> {
  List<StrokeModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<StrokeModel>, List<StrokeModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<StrokeModel>, List<StrokeModel>>,
              List<StrokeModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
