class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNTQ5MGIxZjAzNDg3MmJlYWVmMWRiYmY1ZWJiMWFjMyIsIm5iZiI6MTczNDUxODExOC4yODQsInN1YiI6IjY3NjJhNTY2NjM4NTM2NTliZDRhMjM1NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AvdsrixuQpp9LcSqm025gOHH4IYHjuM0eHxp2UKLYn0'; // Replace with your TMDb API key

  static const String searchMovies = '/search/movie';
  // API Endpoints
  static const String popularMovies = '/movie/popular';
  static const String movieDetails = '/movie/';
  // cridts
  static String movieCredits(int movieId) => '/movie/$movieId/credits';
}
