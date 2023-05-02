


import 'package:appcinema/domain/entities/movie_entity.dart';
import 'package:appcinema/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideShowProvider = Provider<List<MovieEntity>>((ref){

  final nowPlayingMovies = ref.watch( nowPlayingMovieProvider );

  if( nowPlayingMovies.isEmpty ) return [];

  return nowPlayingMovies.sublist(0,6);

});