import '../../../../shared/models/stroke_model.dart';
import '../../domain/repositories/content_creation_repository.dart';
import '../datasources/content_creation_remote_data_source.dart';

// [DOC]: [LAYER: DATA]
// Este repositorio asume la responsabilidad de traducir el lenguaje abstracto del Dominio
// a los objetos y requisitos de JSON puros para que el RemoteDataSource los procese.

class ContentCreationRepositoryImpl implements IContentCreationRepository {
  final IContentCreationRemoteDataSource remoteDataSource;

  ContentCreationRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> submitIdea(String content, String userId) async {
    await remoteDataSource.insertIdea(content, userId);
  }

  @override
  Future<void> submitDoodle(List<StrokeModel> strokes, String userId, String? ideaId) async {
    // [DOC]: Transformamos la lista tipada (Domain) a un objeto Map en crudo (Data)
    // para abstraer la dependencia JSON del Datasource exterior.
    final doodleJsonArray = strokes.map((s) => s.toJson()).toList();
    await remoteDataSource.insertDoodle(doodleJsonArray, userId, ideaId);
  }
}
