
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


    return CustomScrollView(
      slivers: [


        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),


         SliverList(delegate: SliverChildBuilderDelegate(
          (context, index){
            return  Column(

                children: [
            
            
                  MoviesSlideShow(movies: slideShowMovies), 
            
                  MovieHorizontalListView(
                    movies: nowPlayingMovies, 
                    title: 'No Cinema',
                    subTitle: 'Lunes 20',
                    loadNextPage: () => ref.read( nowPlayingMovieProvider.notifier).loadNextPage(), 
                  ),
            
            
                  MovieHorizontalListView(
                    movies: nowPlayingMovies, 
                    title: 'Brevemente',
                    subTitle: 'Em Julho',
                    loadNextPage: () => ref.read( nowPlayingMovieProvider.notifier).loadNextPage(), 
                  ),
            
                  MovieHorizontalListView(
                    movies: nowPlayingMovies, 
                    title: 'Populares',
                    loadNextPage: () => ref.read( nowPlayingMovieProvider.notifier).loadNextPage(), 
                  ),
            
                  MovieHorizontalListView(
                    movies: nowPlayingMovies, 
                    title: 'Melhor Qualificacao',
                    subTitle: 'De todos os tempos',
                    loadNextPage: () => ref.read( nowPlayingMovieProvider.notifier).loadNextPage(), 
                  ),

                  const SizedBox( height: 30,)
                ],
    
              );
           
          }, childCount: 10)),


      ]
    );
  }
}
