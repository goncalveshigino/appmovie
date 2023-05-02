import 'package:appcinema/infrastructure/mappers/movie_mapper.dart';
import 'package:dio/dio.dart';


import 'package:appcinema/config/constants/environment.dart';
import 'package:appcinema/domain/datasources/movies_datasource.dart';

import 'package:appcinema/infrastructure/models/moviedb/moviedb_response_model.dart';
import 'package:appcinema/domain/entities/movie_entity.dart';


class MoviedbDatasourceImpl extends MoviesDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey, 
        'language': 'pt-Pt'
      } 
    )
  );


  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing'); 

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<MovieEntity> movies =  movieDbResponse.results
    .where((movieDb) => movieDb.posterPath != 'no-poster')
    .map(
      (movieDb) => MovieMapper.movieDBToEntity(movieDb)
    ).toList();

    
    
    return movies;
  }



}