
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';



class HomeScreen extends StatelessWidget {
  
  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(), 
      bottomNavigationBar: CustomBottomNavigationBar(),
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

    final slideShowMovies = ref.watch( moviesSlideShowProvider );
    final nowPlayingMovies = ref.watch( nowPlayingMovieProvider );


    return Column(
      children: [

       const CustomAppBar(),

        MoviesSlideShow(movies: slideShowMovies), 

        MovieHorizontalListView(
          movies: nowPlayingMovies, 
          title: 'No Cinema',
          subTitle: 'Lunes 20',
          loadNextPage: () {  }, 
        )
      ],

    );
  }
}
