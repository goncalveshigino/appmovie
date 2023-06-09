import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:appcinema/presentation/widgets/actors/actors_by_movie.dart';
import 'package:appcinema/presentation/widgets/videos/videos_from_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:appcinema/presentation/providers/providers.dart';


import '../../../config/helpers/human_format.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../widgets/widgets.dart';

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
    ref.read(actorByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold( body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {

  final MovieEntity movie;

  const _MovieDetails({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        _TitleAndOverview(movie: movie, size: size, textStyles: textStyles,), 

        _Genres(movie: movie), 

        ActorsByMovie(movieId: movie.id.toString()), 

     
        VideosFromMovie(movieId: movie.id),

        SimilarMovies(movieId: movie.id ),
     
      ],
    );
  }
}


class _TitleAndOverview extends StatelessWidget {

  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyles,
  });

  final MovieEntity movie;
  final Size size;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
            ),
          ),

          const SizedBox( width: 10 ),

          // Descripción
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( movie.title, style: textStyles.titleLarge ),
                Text( movie.overview ),

                const SizedBox(height: 10 ),
                
                MovieRating(voteAverage: movie.voteAverage ),

                Row(
                  children: [
                    const Text('Estreno:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5 ),
                    Text(HumanFormat.shortDate(movie.releaseDate))
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}


class _Genres extends StatelessWidget {
  const _Genres({
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ...movie.genreIds.map((gender) => Container(
              margin: const EdgeInsets.only( right: 10),
              child: Chip(
                label: Text( gender ),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
              ),
            ))
          ],
        ),
      ),
    );
  }
}




class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];

            return Container(
              padding: const EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInRight(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        actor.profilePath,
                        height: 180,
                        width: 135,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(actor.name, maxLines: 2),
                  Text(
                    actor.character ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}






class _CustomSliverAppBar extends ConsumerWidget {

  final MovieEntity movie;

  const _CustomSliverAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context, ref) {

    final AsyncValue isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
      
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {

            //ref.read(localStorageRepositoryProvider).toogleFavorite(movie);
            
            await ref.read(favoriteMoviesProvider.notifier).toogleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFuture.when(
            loading: () => const CircularProgressIndicator(strokeWidth: 2 ),
            data: (isFavorite) => isFavorite 
            ? const Icon (Icons.favorite_rounded, color: Colors.red, size: 30)
            : const Icon(Icons.favorite_border, size: 30),
            error: (_, __) => throw UnimplementedError(), 
          )
         
        ) 
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only( bottom: 0), 
        title: isDarkMode 
        ? _CustomGrandient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.7, 1.0],
          colors: [
            Colors.transparent,
            scaffoldBackgroundColor
          ]
        ): null,
        background: Stack(
          children: [

            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGrandient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),
             
            const _CustomGrandient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              stops: [0.8, 1.0],
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
            ),

            const _CustomGrandient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class _CustomGrandient extends StatelessWidget {

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGrandient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}




  //  Padding(
  //         padding: const EdgeInsets.all(8),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
              
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(20),
  //               child: Image.network(
  //                 movie.posterPath,
  //                 width: size.width * 0.3,
  //               ),
  //             ),

  //             const SizedBox(
  //               width: 10,
  //             ),

  //             SizedBox(
  //               width: (size.width - 40) * 0.7,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(movie.title, style: textStyles.titleLarge),
  //                   Text(movie.overview),

  //                  const SizedBox( height: 10,), 

  //                    MovieRating(voteAverage: movie.voteAverage ),

  //                    Row(
  //                     children: [
  //                       const Text('Estreno:', style: TextStyle(fontWeight: FontWeight.bold)),
  //                       const SizedBox(width: 5 ),
  //                       Text(HumanFormat.shortDate(movie.releaseDate))
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8),
  //         child: Wrap(
  //           children: [
  //             ...movie.genreIds.map((gender) => Container(
  //                   margin: const EdgeInsets.only(right: 10),
  //                   child: Chip(
  //                     label: Text(gender),
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(20)),
  //                   ),
  //                 ))
  //           ],
  //         ),
  //       ),
  //       _ActorsByMovie(movieId: movie.id.toString()),
  //       const SizedBox(
  //         height: 50,
  //       )
