import 'dart:convert';
import 'dart:io';

import 'package:movies/src/core/api/api.dart';
import 'package:movies/src/features/movies/models/api_response.dart';
import 'package:movies/src/features/movies/models/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movies/src/features/movies/models/movie_details.dart';

final moviesRepositoryProvider = Provider(
  (ref) => MoviesRepository(),
);

class MoviesRepository {
  final _api = TMDBApi();

  Future<TMDBApiResponse> fetchTrendingMovies({int page = 1}) {
    return _getData(
      uri: _api.trendingMovies(page),
      builder: (data) {
        return TMDBApiResponse.fromJson(data);
      },
    );
  }

  Future<TMDBApiResponse> fetchPopularMovies({int page = 1}) {
    return _getData(
      uri: _api.popularMovies(page),
      builder: (data) {
        return TMDBApiResponse.fromJson(data);
      },
    );
  }

  Future<TMDBApiResponse> fetchNowPlayingMovies({int page = 1}) {
    return _getData(
      uri: _api.nowPlayingMovies(page),
      builder: (data) {
        return TMDBApiResponse.fromJson(data);
      },
    );
  }

  Future<Movie> fetchMovieById(int movieId) {
    return _getData(
      uri: _api.movie(movieId),
      builder: (data) {
        return Movie.fromJson(data);
      },
    );
  }

  Future<MovieDetails> fetchMovieDetails(int movieId) {
    return _getData(uri: _api.movieDetails(movieId), builder: (data) {
      return MovieDetails.fromJson(data);
    },);
  }

  String getImageUrl(String imagePath) {
    return _api.image(imagePath).toString();
  }
  
  Future<T> _getData<T>(
      {required Uri uri, required T Function(dynamic data) builder}) async {
    try {
      final response = await http.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        default:
          throw Exception();
      }
    } on SocketException {
      rethrow;
    }
  }
}
