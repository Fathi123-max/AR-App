part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class LoadMovies extends MovieListEvent {
  const LoadMovies();
}

class LoadMoreMovies extends MovieListEvent {
  const LoadMoreMovies();
}

class LoadFavorites extends MovieListEvent {
  const LoadFavorites();
}

class LoadWatchlist extends MovieListEvent {
  const LoadWatchlist();
}

class ToggleFavorite extends MovieListEvent {
  final MovieModel movie;

  const ToggleFavorite(this.movie);
}

class ToggleWatchlist extends MovieListEvent {
  final MovieModel movie;

  const ToggleWatchlist(this.movie);
}

//cridits
class GetMovieCredits extends MovieListEvent {
  final int movieId; // Pass the movieId as a parameter

  const GetMovieCredits(this.movieId);
}
