import 'package:appcinema/infrastructure/mappers/movie_mapper.dart';
import 'package:appcinema/infrastructure/models/moviedb/movie_details.dart';
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


  List<MovieEntity> _jsonToMovies( Map<String, dynamic> json){
     
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<MovieEntity> movies =  movieDbResponse.results
    .where((movieDb) => movieDb.posterPath != 'no-poster')
    .map(
      (movieDb) => MovieMapper.movieDBToEntity(movieDb)
    ).toList();

    
    return movies;
  }


  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing', 
     queryParameters: {
      'page': page
     }
    ); 

   return _jsonToMovies(response.data);

  
  }
  
  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) async {
     
    final response = await dio.get('/movie/popular', 
     queryParameters: {
      'page': page
     }
    ); 

    
    return _jsonToMovies(response.data);

  }
  
  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) async {
    
      final response = await dio.get('/movie/top_rated',
       queryParameters: {
        'page': page
      },);


      return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) async {
     
        final response = await dio.get('/movie/upcoming', 
        queryParameters: {
        'page': page
      },);

 


      return _jsonToMovies(response.data);
  }
  
  @override
  Future<MovieEntity> getMovieById(String id) async {
    
    final respose = await dio.get('/movie/$id');
    if(respose.statusCode != 200) throw Exception('Movie with id: $id not found '); 


    final movieDetails = MovieDetails.fromJson( respose.data );
    final MovieEntity movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
    
  }
  
  @override
  Future<List<MovieEntity>> serachMovies(String query) async {

    if( query.isEmpty ) return [];

    final response = await dio.get('/search/movie', queryParameters: {
      'query': query
    }
    );

    return _jsonToMovies(response.data);
    
  }
  
  @override
  Future<List<MovieEntity>> getSimilarMovies(int movieId) async {
     final response = await dio.get('/movie/$movieId/similar');
     return _jsonToMovies(response.data);
  }

}