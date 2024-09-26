class Movie {
  final int id;
  final String posterPath;
  final String title;
  final String releaseDate;
  final double rating;

  Movie({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      posterPath: json['poster_path'] ?? '',
      title: json['title'] ?? '',
      releaseDate: json['release_date'] ?? '',
      rating: json['vote_average'] ?? 0,
    );
  }
  
}
