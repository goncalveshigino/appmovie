import 'package:appcinema/domain/domain.dart';
import 'package:appcinema/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchNotiferMoviesNotifier, List<MovieEntity>>((ref){

   final movieRepository = ref.read( movieRepositoryProvider );

   return SearchNotiferMoviesNotifier(
    ref: ref, 
    searchMovies: movieRepository.serachMovies
    );
});

typedef SearMoviesCallback = Future<List<MovieEntity>> Function(String query);


class SearchNotiferMoviesNotifier extends StateNotifier<List<MovieEntity>> {

  final SearMoviesCallback searchMovies;
  final Ref ref;

  SearchNotiferMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  Future<List<MovieEntity>> searchMoviesByQuery(String query) async {

    final List<MovieEntity> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}
