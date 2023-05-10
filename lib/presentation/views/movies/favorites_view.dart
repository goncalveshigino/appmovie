import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../../../domain/domain.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class FavoritesViews extends ConsumerStatefulWidget {



  const FavoritesViews({super.key});
 

  @override
  FavoritesViewsState createState() => FavoritesViewsState();
}

class FavoritesViewsState extends ConsumerState<FavoritesViews> with AutomaticKeepAliveClientMixin {

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
    super.build(context);

    final favoriteMovies = ref.watch( favoriteMoviesProvider ).values.toList();

    if ( favoriteMovies.isEmpty){
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Icon( Icons.favorite_outline_sharp, size: 60, color: colors.primary,), 
            Text('Ohhh Nao!!', style: TextStyle( fontSize: 30, color: colors.primary),), 
            const Text('Nao tens filmes favoritos', style: TextStyle( fontSize: 20, color: Colors.black45),),

            const SizedBox( height: 20 ), 
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'), 
              child: const Text('comece a buscar')
            )

          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
         movies: favoriteMovies, 
         loadNextPage: loadNextPage
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
