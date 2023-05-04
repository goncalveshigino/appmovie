import 'package:appcinema/domain/entities/movie_entity.dart';



abstract class MoviesDataSource {

 Future<List<MovieEntity>> getNowPlaying({ int page = 1 });

 Future<List<MovieEntity>> getPopular({ int page = 1 });

 Future<List<MovieEntity>> getTopRated({ int page = 1 });

 Future<List<MovieEntity>> getUpcoming({ int page = 1 });



}