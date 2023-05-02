import 'package:appcinema/presentation/providers/movies/movies_provider.dart';
import 'package:appcinema/presentation/widgets/movies/movies_slideshow.dart';
import 'package:appcinema/presentation/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read( nowPlayingMovieProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch( nowPlayingMovieProvider );


    return Column(
      children: [

       const CustomAppBar(),

        MoviesSlideShow(movies: nowPlayingMovies)
      ],

    );
  }
}
