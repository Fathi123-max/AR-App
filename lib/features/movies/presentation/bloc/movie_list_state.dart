part of 'movie_list_bloc.dart';

enum MovieListStatus { initial, loading, success, failure }

class MovieListState extends Equatable {
  final MovieListStatus status;
  final List<Movie> movies;
  final List<Movie> favoriteMovies;
  final List<Movie> watchlistMovies;
  final bool hasReachedMax;
  final String? error;

  const MovieListState({
    this.status = MovieListStatus.initial,
    this.movies = const [],
    this.favoriteMovies = const [],
    this.watchlistMovies = const [],
    this.hasReachedMax = false,
    this.error,
  });

  MovieListState copyWith({
    MovieListStatus? status,
    List<Movie>? movies,
    List<Movie>? favoriteMovies,
    List<Movie>? watchlistMovies,
    bool? hasReachedMax,
    String? error,
  }) {
    return MovieListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movies,
        favoriteMovies,
        watchlistMovies,
        hasReachedMax,
        error,
      ];
}