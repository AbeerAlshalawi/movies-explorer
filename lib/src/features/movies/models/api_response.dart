import 'package:movies/src/features/movies/models/movie.dart';

class TMDBApiResponse {
  TMDBApiResponse({required this.totalPages, required this.results});

  final int totalPages;
  final List<Movie> results;

  factory TMDBApiResponse.fromJson(Map<String, dynamic> json) {
    return TMDBApiResponse(
        totalPages: json['total_pages'],
        results: (json['results'] as List)
            .map(
              (item) => Movie.fromJson(item),
            )
            .toList());
  }
}
