// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ideasStream)
final ideasStreamProvider = IdeasStreamProvider._();

final class IdeasStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IdeaModel>>,
          List<IdeaModel>,
          Stream<List<IdeaModel>>
        >
    with $FutureModifier<List<IdeaModel>>, $StreamProvider<List<IdeaModel>> {
  IdeasStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ideasStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ideasStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<IdeaModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<IdeaModel>> create(Ref ref) {
    return ideasStream(ref);
  }
}

String _$ideasStreamHash() => r'60f017b5d926df90861fad88f98537aa8e0f122f';
