import '../../domain/domain.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
   return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toogleFavorite(MovieEntity movieEntity) {
   return datasource.toogleFavorite(movieEntity);
  }
}
