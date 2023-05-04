import 'package:appcinema/domain/datasources/movies_datasource.dart';
import 'package:appcinema/domain/entities/movie_entity.dart';
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
    return dataSource.getPopular(page:page);
  }
  
  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) {
   return dataSource.getTopRated(page:page);
  }
  
  @override
  Future<List<MovieEntity>> getUpComing({int page = 1}) {
   return dataSource.getUpcoming(page:page);
  }
}
