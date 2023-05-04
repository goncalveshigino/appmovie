import 'package:appcinema/domain/entities/movie_entity.dart';
import 'package:appcinema/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMovieProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallback = Future<List<MovieEntity>> Function({int page});

class MoviesNotifier extends StateNotifier<List<MovieEntity>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    print('Loading more movies');

    currentPage++;

    final List<MovieEntity> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    isLoading = false;
  }
}
