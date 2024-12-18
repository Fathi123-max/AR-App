part of 'movie_list_bloc.dart';

enum MovieListStatus { initial, loading, success, failure }

class MovieListState extends Equatable {
  final MovieListStatus status;
  final List<MovieModel> movies;
  final List<MovieModel> favoriteMovies;
  final List<MovieModel> watchlistMovies;
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
    List<MovieModel>? movies,
    List<MovieModel>? favoriteMovies,
    List<MovieModel>? watchlistMovies,
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
