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
}
