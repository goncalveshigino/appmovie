import 'package:flutter/material.dart';

import '../../../config/helpers/human_format.dart';



class MovieRating extends StatelessWidget {

  final double voteAverage; 


  const MovieRating({
    super.key,
    required this.voteAverage
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
          const SizedBox(width: 3),
          Text(HumanFormat.number(voteAverage, 1),
              style: textStyles.bodyMedium
                  ?.copyWith(color: Colors.yellow.shade800)),
          
        ],
      ),
    );
  }
}
