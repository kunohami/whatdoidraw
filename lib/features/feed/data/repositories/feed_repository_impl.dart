import '../../domain/entities/idea_model.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_source.dart';

// [DOC]: [LAYER: DATA] 
// El RepositoryImpl es el puente. Pertenece a Data, pero implementa el contrato de Domain.
// Aquí se orquesta la inteligencia de datos: ¿Debo pedir datos de red (RemoteDataSource) 
// o los saco de caché (LocalDataSource)?

class FeedRepositoryImpl implements IFeedRepository {
  final IFeedRemoteDataSource remoteDataSource;
  
  FeedRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<IdeaModel>> watchIdeas() {
    // Al no tener offline support por ahora, inyectamos directamente de remoto
    return remoteDataSource.streamIdeas();
  }
}
