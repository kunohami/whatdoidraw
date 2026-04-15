// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doodle_canvas_viewmodel.dart';

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

String _$doodleCanvasHash() => r'b2dd57f3126f9ea02b5ad3ee492a6a3798146d74';

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
