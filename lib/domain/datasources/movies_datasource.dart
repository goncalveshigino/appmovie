import 'package:appcinema/domain/entities/movie_entity.dart';
import 'package:appcinema/domain/entities/video_entity.dart';



abstract class MoviesDataSource {

 Future<List<MovieEntity>> getNowPlaying({ int page = 1 });

 Future<List<MovieEntity>> getPopular({ int page = 1 });

 Future<List<MovieEntity>> getTopRated({ int page = 1 });

 Future<List<MovieEntity>> getUpcoming({ int page = 1 });

 Future<MovieEntity> getMovieById( String id);

 Future<List<MovieEntity>> serachMovies( String query );

 Future<List<MovieEntity>> getSimilarMovies( int movieId ); 

 Future<List<VideoEntity>> getYoutubeVideosById( int movieId );

}