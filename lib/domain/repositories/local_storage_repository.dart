import '../domain.dart';

abstract class LocalStorageRepository {
  
  Future<void> toogleFavorite( MovieEntity movieEntity );

  Future<bool> isMovieFavorite( int movieId );

  Future<List<MovieEntity>> loadMovies({ int limit = 10, offset = 0 });
  
}