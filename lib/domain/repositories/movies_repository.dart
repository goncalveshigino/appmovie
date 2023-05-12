import 'package:appcinema/domain/entities/movie_entity.dart';


abstract class MoviesRepository {

 Future<List<MovieEntity>> getNowPlaying({ int page = 1 }); 

 Future<List<MovieEntity>> getPopular({ int page = 1 });

 Future<List<MovieEntity>> getTopRated({ int page = 1 });

 Future<List<MovieEntity>> getUpComing({ int page = 1 });

 Future<MovieEntity> getMovieById( String id);

 Future<List<MovieEntity>> serachMovies( String query );

 Future<List<MovieEntity>> getSimilarMovies( int movieId );

}