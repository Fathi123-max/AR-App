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
  final Movie movie;

  const ToggleFavorite(this.movie);
}

class ToggleWatchlist extends MovieListEvent {
  final Movie movie;

  const ToggleWatchlist(this.movie);
}
