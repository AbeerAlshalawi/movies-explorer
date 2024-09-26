import 'package:movies/src/features/movies/models/api_response.dart';
import 'package:movies/src/features/movies/models/home.dart';
import 'package:movies/src/features/movies/repository/movies_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/src/features/movies/models/movie.dart';
import 'package:movies/src/features/movies/models/movie_details.dart';

final homeProvider = FutureProvider(
  (ref) async {
    final moviesRepository = ref.watch(moviesRepositoryProvider);
    final responseList = await Future.wait([
      moviesRepository.fetchTrendingMovies(),
      moviesRepository.fetchPopularMovies(page: 1),
      moviesRepository.fetchNowPlayingMovies(page: 1)
    ]);

    return Home(
      trendingMovies: responseList[0].results,
      popularMovies: responseList[1].results,
      nowPlayingMovies: responseList[2].results,
    );
  },
);

final trendingMoviesProvider = FutureProvider.family<TMDBApiResponse, int>(
  (ref, page) async {
    final moviesRepository = ref.watch(moviesRepositoryProvider);

    return await moviesRepository.fetchTrendingMovies(page: page);
  },
);

final popularMoviesProvider = FutureProvider.family<TMDBApiResponse, int>(
  (ref, page) async {
    final moviesRepository = ref.watch(moviesRepositoryProvider);

    return await moviesRepository.fetchPopularMovies(page: page);
  },
);

final nowMoviesProvider = FutureProvider.family<TMDBApiResponse, int>(
  (ref, page) async {
    final moviesRepository = ref.watch(moviesRepositoryProvider);

    return await moviesRepository.fetchNowPlayingMovies(page: page);
  },
);

final detailsProvider = FutureProvider.family<MovieDetails, int>(
  (ref, movieId) async {
    final detailsRepository = ref.watch(moviesRepositoryProvider);

    return await detailsRepository.fetchMovieDetails(movieId);
  },
);

final movieListProvider = FutureProvider.family<List<Movie>, List<int>>(
  (ref, ids) async {
    return await Future.wait(ids.map(
      (e) => ref.read(moviesRepositoryProvider).fetchMovieById(e),
    ));
  },
);

final imageProvider = Provider.family<String, String>(
  (ref, imagePath) {
    final moviesRepository = ref.watch(moviesRepositoryProvider);

    return moviesRepository.getImageUrl(imagePath);
  },
);
