import '../../domain/domain.dart';

class IsarDatasourceImpl extends LocalStorageDatasource {


  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toogleFavorite(MovieEntity movieEntity) {
    // TODO: implement toogleFavorite
    throw UnimplementedError();
  }

}