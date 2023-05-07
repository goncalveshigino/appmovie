import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:appcinema/domain/domain.dart';




typedef SearchMoviesCallback = Future<List<MovieEntity>> Function( String query );

class SearchMovieDelegate extends SearchDelegate<MovieEntity?> {


  final SearchMoviesCallback searchMovies;
  SearchMovieDelegate({required this.searchMovies});


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
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot){

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder:(context,index){
            final movie = movies[index];
            return ListTile( title: Text( movie.title) );
          } ,
        );
      },
    );
  }
}
