import 'package:appcinema/domain/datasources/movies_datasource.dart';
import 'package:appcinema/domain/entities/movie_entity.dart';
import 'package:appcinema/domain/entities/video_entity.dart';
import 'package:appcinema/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  
  final MoviesDataSource dataSource;
  MovieRepositoryImpl(this.dataSource);

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) {
    return dataSource.getPopular(page: page);
  }

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) {
    return dataSource.getTopRated(page: page);
  }

  @override
  Future<List<MovieEntity>> getUpComing({int page = 1}) {
    return dataSource.getUpcoming(page: page);
  }

  @override
  Future<MovieEntity> getMovieById(String id) {
    return dataSource.getMovieById(id);
  }

  @override
  Future<List<MovieEntity>> serachMovies(String query) {
    return dataSource.serachMovies(query);
  }

  @override
  Future<List<MovieEntity>> getSimilarMovies(int movieId) {
    return dataSource.getSimilarMovies(movieId);
  }

  @override
  Future<List<VideoEntity>> getYoutubeVideosById(int movieId) {
    return dataSource.getYoutubeVideosById(movieId);
  }
}
