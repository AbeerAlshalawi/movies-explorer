import 'package:movies/src/features/movies/models/api_response.dart';
import 'package:movies/src/features/movies/view/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieGrid extends ConsumerWidget {
  const MovieGrid(
      {super.key, required this.title, required this.movieProvider});

  final String title;
  final FutureProviderFamily<TMDBApiResponse, int> movieProvider;

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.45,
        ),
        itemBuilder: (context, index) {
          final page = index ~/ pageSize + 1;
          final indexInPage = index % pageSize;

          final AsyncValue<TMDBApiResponse> responseAsync =
              ref.watch(movieProvider(page));
          return responseAsync.when(
            data: (response) {
              if (indexInPage >= response.results.length) {
                return null;
              }
              return MovieCard(response.results[indexInPage]);
            },
            loading: () => const Center(),
            error: (error, stackTrace) => const Center(),
          );
        },
      ),
    );
  }
}
