import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/data/models/person_model.dart';
import '../../domain/repositories/movie_repository.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository repository;
  int _currentPage = 1;

  /// Event handlers for [MovieListBloc]
  ///
  /// Handles all events coming to the [MovieListBloc] and emits a new state
  /// based on the event.

  MovieListBloc({required this.repository}) : super(const MovieListState()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<LoadFavorites>(_onLoadFavorites);
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ToggleFavorite>(_onToggleFavorite);
    on<ToggleWatchlist>(_onToggleWatchlist);
    // cridits
    on<GetMovieCredits>(_onGetMovieCredits);
  }

  Future<void> _onGetMovieCredits(
    GetMovieCredits event,
    Emitter<MovieListState> emit,
  ) async {
    final result = await repository.getMovieCredits(event.movieId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieListStatus.failure,
        error: failure.message,
      )),
      (credits) => emit(
          state.copyWith(credits: credits, status: MovieListStatus.success)),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<MovieListState> emit,
  ) async {
    final result = await repository.toggleFavorite(event.movie);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieListStatus.failure,
        error: failure.message,
      )),
      (isFavorite) {
        if (isFavorite) {
          // Add to favorites
          emit(state.copyWith(
            favoriteMovies: [
              ...state.favoriteMovies,
              event.movie.copyWith(isFavorite: true)
            ],
          ));
        } else {
          // Remove from favorites
          emit(state.copyWith(
            favoriteMovies: state.favoriteMovies
                .where((movie) => movie.id != event.movie.id)
                .toList(),
          ));
        }
      },
    );
  }

  Future<void> _onToggleWatchlist(
    ToggleWatchlist event,
    Emitter<MovieListState> emit,
  ) async {
    final result = await repository.toggleWatchlist(event.movie);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieListStatus.failure,
        error: failure.message,
      )),
      (isWatchlisted) {
        if (isWatchlisted) {
          // Add to watchlist
          emit(state.copyWith(
            watchlistMovies: [
              ...state.watchlistMovies,
              event.movie.copyWith(isWatchlisted: true)
            ],
          ));
        } else {
          // Remove from watchlist
          emit(state.copyWith(
            watchlistMovies: state.watchlistMovies
                .where((movie) => movie.id != event.movie.id)
                .toList(),
          ));
        }
      },
    );
  }

  Future<void> _onLoadMovies(
    LoadMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(status: MovieListStatus.loading));

    final result = await repository.getPopularMovies(page: 1);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieListStatus.failure,
        error: failure.message,
      )),
      (movies) {
        _currentPage = 1;
        emit(state.copyWith(
          status: MovieListStatus.success,
          movies: movies,
          hasReachedMax: movies.isEmpty, // Adjusted condition
        ));
      },
    );
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMovies event,
    Emitter<MovieListState> emit,
  ) async {
    if (state.hasReachedMax) {
      return; // Don't attempt to load more if max is reached
    }

    emit(state.copyWith(status: MovieListStatus.loading));

    final result = await repository.getPopularMovies(page: _currentPage + 1);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieListStatus.failure,
        error: failure.message,
      )),
      (movies) {
        if (movies.isEmpty) {
          emit(state.copyWith(hasReachedMax: true)); // No new movies, set flag
        } else {
          _currentPage++;
          emit(state.copyWith(
            status: MovieListStatus.success,
            movies: List.of(state.movies)..addAll(movies),
            hasReachedMax: movies.length < 20, // Adjusted condition
          ));
        }
      },
    );
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<MovieListState> emit,
  ) async {
    final result = await repository.getFavoriteMovies();

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieListStatus.failure,
        error: failure.message,
      )),
      (movies) => emit(state.copyWith(favoriteMovies: movies)),
    );
  }

  Future<void> _onLoadWatchlist(
    LoadWatchlist event,
    Emitter<MovieListState> emit,
  ) async {
    final result = await repository.getWatchlistMovies();

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieListStatus.failure,
        error: failure.message,
      )),
      (movies) => emit(state.copyWith(watchlistMovies: movies)),
    );
  }
}
