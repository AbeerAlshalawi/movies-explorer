class TMDBApi {
  final String _apiKey = 'YOUR_API_KEY';
  final String _baseUrl = 'api.themoviedb.org';

  Uri trendingMovies(int page) =>
      _buildUri(endpoint: 'trending/movie/week', page: page);

  Uri popularMovies(int page) =>
      _buildUri(endpoint: 'movie/popular', page: page);

  Uri upcomingMovies(int page) =>
      _buildUri(endpoint: 'movie/upcoming', page: page);

  Uri nowPlayingMovies(int page) =>
      _buildUri(endpoint: 'movie/now_playing', page: page);

  Uri topRatedMovies(int page) =>
      _buildUri(endpoint: 'movie/top_rated', page: page);

  Uri movie(int movieId) => _buildUri(endpoint: 'movie/$movieId');

  Uri movieDetails(int movieId) => _buildUri(
      endpoint: 'movie/$movieId',
      query: {'append_to_response': 'credits,similar'});

  Uri image(String imagePath) => Uri.parse('https://image.tmdb.org/t/p/w500$imagePath');

  Uri _buildUri(
      {required String endpoint, int? page, Map<String, dynamic>? query}) {
    Map<String, dynamic> queryParameters = {
      'api_key': _apiKey,
      if (page != null) 'page': page.toString(),
    };

    if (query != null) {
      queryParameters.addAll(query);
    }

    final uri = Uri(
        scheme: 'https',
        host: _baseUrl,
        path: '/3/$endpoint',
        queryParameters: queryParameters);
    return uri;
  }
}
