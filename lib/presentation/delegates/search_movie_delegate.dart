import 'package:animate_do/animate_do.dart';
import 'package:appcinema/domain/domain.dart';
import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate<MovieEntity?> {
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
    return const Text('buildSuggestions');
  }
}
