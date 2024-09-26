import 'package:movies/src/core/constants/app_sizes.dart';
import 'package:movies/src/features/movies/models/api_response.dart';
import 'package:movies/src/features/movies/models/movie.dart';
import 'package:movies/src/features/movies/view/screens/movie_grid.dart';
import 'package:movies/src/features/movies/view/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({
    super.key,
    required this.title,
    required this.movies,
    this.movieProvider,
  });

  final String title;
  final List<Movie> movies;
  final FutureProviderFamily<TMDBApiResponse, int>? movieProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (movieProvider != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieGrid(title: title, movieProvider: movieProvider!,),
                  ));
                },
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
          ],
        ),
        gapH16,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [for (final movie in movies) MovieCard(movie)],
          ),
        )
      ],
    );
  }
}
