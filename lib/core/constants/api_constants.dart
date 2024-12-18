class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String apiKey =
      '35490b1f034872beaef1dbbf5ebb1ac3'; // Replace with your TMDb API key

  static const String searchMovies = '/search/movie';
  // API Endpoints
  static const String popularMovies = '/movie/popular';
  static const String movieDetails = '/movie/';
  static const String movieCredits = '/movie/{movie_id}/credits';
}
