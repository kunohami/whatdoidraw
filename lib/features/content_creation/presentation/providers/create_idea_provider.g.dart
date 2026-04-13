// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_idea_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateIdeaController)
final createIdeaControllerProvider = CreateIdeaControllerProvider._();

final class CreateIdeaControllerProvider
    extends $NotifierProvider<CreateIdeaController, bool> {
  CreateIdeaControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createIdeaControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createIdeaControllerHash();

  @$internal
  @override
  CreateIdeaController create() => CreateIdeaController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$createIdeaControllerHash() =>
    r'972085e6c28ba28bb777c8bb9be936fc31ae7369';

abstract class _$CreateIdeaController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
