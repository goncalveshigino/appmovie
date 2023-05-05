import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:appcinema/presentation/providers/movies/movie_info_provider.dart';

import '../../../domain/entities/movie_entity.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId,
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [_CustomSliverAppBar(movie: movie)],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final MovieEntity movie;

  const _CustomSliverAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric( horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle( fontSize: 20), 
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [

            SizedBox.expand(
              child: Image.network(
                movie.posterPath, 
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, 
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [
                      Colors.transparent, 
                      Colors.black87
                    ]
                  )
                )
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft, 
                    stops: [0.0, 0.4],
                    colors: [
                      Colors.black87, 
                      Colors.transparent
                    ]
                  )
                )
              ),
            )

          ],
        ),
      ),
    );
  }
}
