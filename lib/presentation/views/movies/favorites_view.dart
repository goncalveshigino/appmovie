import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../domain/domain.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class FavoritesViews extends ConsumerStatefulWidget {



  const FavoritesViews({super.key});
 

  @override
  FavoritesViewsState createState() => FavoritesViewsState();
}

class FavoritesViewsState extends ConsumerState<FavoritesViews> {

  bool isLastPage = false; 
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {

    if( isLoading || isLastPage ) return ;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if( movies.isEmpty ){
       isLastPage = true;
    }

  }



  @override
  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch( favoriteMoviesProvider ).values.toList();

    return Scaffold(
      body: MovieMasonry(
         movies: favoriteMovies, 
         loadNextPage: loadNextPage
      ),
    );
  }
}
