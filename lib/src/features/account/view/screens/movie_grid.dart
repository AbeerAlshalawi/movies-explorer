import 'package:movies/src/features/movies/view/widgets/movie_card.dart';
import 'package:movies/src/features/movies/viewmodel/movies_viewmodel.dart';
import 'package:movies/src/shared/view/screens/error_screen.dart';
import 'package:movies/src/shared/view/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieGrid extends ConsumerWidget {
  const MovieGrid({super.key, required this.title, required this.movieIds});

  final String title;
  final List<int> movieIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(movieListProvider(movieIds));

    return moviesAsync.when(
      data: (movies) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.45,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) => MovieCard(movies[index]),
        ),
      ),
      error: (error, stackTrace) => ErrorScreen(error),
      loading: () => const LoadingScreen(),
    );
  }
}
