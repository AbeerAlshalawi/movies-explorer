import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/src/core/constants/app_sizes.dart';
import 'package:movies/src/features/movies/view/screens/movie_details_screen.dart';
import 'package:movies/src/features/movies/models/movie.dart';
import 'package:movies/src/features/movies/view/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/features/movies/viewmodel/movies_viewmodel.dart';

class MovieCard extends ConsumerWidget {
  const MovieCard(this.movie, {super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posterUrl = ref.watch(imageProvider(movie.posterPath));

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(movie.id),
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        height: 244,
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: movie.posterPath.isEmpty
                      ? Image.asset('assets/images/empty_poster.png')
                      : Image.network(posterUrl),
                ),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: RatingChip(movie.rating),
                ),
              ],
            ),
            gapH8,
            Text(
              movie.title,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            gapH8,
            Text(
              '${DateTime.tryParse(movie.releaseDate)?.year ?? ''}',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            )
          ],
        ),
      ),
    );
  }
}
