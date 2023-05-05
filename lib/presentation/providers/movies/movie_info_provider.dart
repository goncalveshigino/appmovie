import 'package:appcinema/domain/entities/movie_entity.dart';
import 'package:appcinema/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, MovieEntity>>((ref){
  
  final movieRepository = ref.watch( movieRepositoryProvider );

  return MovieMapNotifier(getMovie: movieRepository.getMovieById );
});



typedef GetMovieCallback = Future<MovieEntity>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,MovieEntity>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({ required this.getMovie}): super({});


  Future<void> loadMovie( String movieId ) async {

    if( state[movieId] != null ) return;
    print('realizando peticion http');
    final movie = await getMovie( movieId );

    state = {...state, movieId: movie };
  }


}