import 'package:movies/src/features/movies/models/movie.dart';

class MovieDetails {
  MovieDetails(
      {required this.backdropPath,
      required this.posterPath,
      required this.title,
      required this.rating,
      required this.releaseDate,
      required this.genres,
      required this.overview,
      required this.similar});

  final String backdropPath;
  final String posterPath;
  final String title;
  final double rating;
  final String releaseDate;
  final List<String> genres;
  final String overview;

  final List<Movie> similar;

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
        backdropPath: json['backdrop_path'] ?? '',
        posterPath: json['poster_path'] ?? '',
        title: json['title'] ?? '',
        rating: json['vote_average'] ?? 0,
        releaseDate: json['release_date'] ?? '',
        genres: (json['genres'] as List)
            .map(
              (item) => item['name'] as String,
            )
            .toList(),
        overview: json['overview'],
        similar: (json['similar']['results'] as List)
            .map(
              (item) => Movie.fromJson(item),
            )
            .toList());
  }
}
