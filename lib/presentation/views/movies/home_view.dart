import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  
  const HomeView({ super.key });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {

    super.initState();

    ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMovieProvider.notifier).loadNextPage();
    ref.read(upComingMovieProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {
    
    final initialLoading = ref.watch(initialLoadingProvider);

    if(initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    final popularMonives = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMovieProvider);
    final upComingMovies = ref.watch(upComingMovieProvider);


    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideShow(movies: slideShowMovies),
            MovieHorizontalListView(
              movies: nowPlayingMovies,
              title: 'No Cinema',
              subTitle: 'Lunes 20',
              loadNextPage: () =>
                  ref.read(nowPlayingMovieProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListView(
              movies: upComingMovies,
              title: 'Brevemente',
              subTitle: 'Em Julho',
              loadNextPage: () =>
                  ref.read(upComingMovieProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListView(
              movies: popularMonives,
              title: 'Populares',
              loadNextPage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListView(
              movies: topRatedMovies,
              title: 'Melhor Qualificacao',
              subTitle: 'De todos os tempos',
              loadNextPage: () =>
                  ref.read(topRatedMovieProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        );
      }, childCount: 1)),
    ]);
  }
}