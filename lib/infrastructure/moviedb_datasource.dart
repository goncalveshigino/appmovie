import 'package:appcinema/config/constants/environment.dart';
import 'package:dio/dio.dart';

import 'package:appcinema/domain/datasources/movies_datasource.dart';
import 'package:appcinema/domain/entities/movie_entity.dart';


class MoviedbDatasource extends MoviesDataSource {

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
    final List<MovieEntity> movies = [];

    
    
    return [];
  }



}