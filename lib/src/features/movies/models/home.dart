import 'package:movies/src/features/movies/models/movie.dart';

class Home {
  Home({
    required this.trendingMovies,
    required this.popularMovies,
    required this.nowPlayingMovies,
  });

  final List<Movie> trendingMovies;
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
}
