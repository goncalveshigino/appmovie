import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';

class MoviePosterLink extends StatelessWidget {

  final MovieEntity movie;

  const MoviePosterLink({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${ movie.id }'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}
