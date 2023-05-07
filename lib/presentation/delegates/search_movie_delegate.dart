import 'dart:async';

import 'package:appcinema/config/helpers/human_format.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:appcinema/domain/domain.dart';




typedef SearchMoviesCallback = Future<List<MovieEntity>> Function( String query );


class SearchMovieDelegate extends SearchDelegate<MovieEntity?> {


  final SearchMoviesCallback searchMovies;
  final List<MovieEntity> initialMovies;

  StreamController<List<MovieEntity>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies, 
    required this.initialMovies,
  });


  void clearStreans(){
    debouncedMovies.close();
  }

 //Debounce Manual
  void _onQueryChanged( String query ){

      if( _debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

       _debounceTimer = Timer(const Duration(milliseconds: 500), () async {

          final movies = await searchMovies( query );
          debouncedMovies.add(movies);
       });
  }


  


  @override
  String get searchFieldLabel => 'Buscar Filmes';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [

      if( query.isNotEmpty )
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
         onPressed: () => query = '',
         icon: const Icon( Icons.clear )
        ),
      )

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          clearStreans(); 
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot){

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder:(context,index) => _MovieItem(
            movie: movies[index], 
            onMovieSelected: (context, movie){
              clearStreans();
              close(context, movie);
            },
            ) ,
        );
      },
    );
  }
}



class _MovieItem extends StatelessWidget {


  final MovieEntity movie;
  final Function onMovieSelected;


  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector( 
      onTap: (){
        onMovieSelected( context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 5),
        child: Row(
          children: [
    
             SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network( 
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
             ), 
    
             const SizedBox( width: 10 ),
    
    
             SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
    
                  Text( movie.title, style: textStyle.titleMedium ), 
    
                  ( movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0,100)}...')
                      : Text( movie.overview ), 
    
                  Row(
                    children: [
                       Icon( Icons.star_half_rounded, color: Colors.yellow.shade800), 
                       const SizedBox( width: 5 ),
                       Text( HumanFormat.number(movie.voteAverage, 1), 
                       style: textStyle.bodyMedium!.copyWith( color: Colors.yellow.shade800),)
                    ],
                  )
    
                ],
              ),
             )
    
          ],
        ),
      ),
    );
  }
}
