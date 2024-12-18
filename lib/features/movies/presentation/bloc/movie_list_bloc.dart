import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository repository;
  int _currentPage = 1;

  MovieListBloc({required this.repository}) : super(const MovieListState()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<LoadFavorites>(_onLoadFavorites);
    on<LoadWatchlist>(_onLoadWatchlist);
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
          hasReachedMax: movies.length < 20,
        ));
      },
    );
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMovies event,
    Emitter<MovieListState> emit,
  ) async {
    if (state.hasReachedMax) return;
    
    emit(state.copyWith(status: MovieListStatus.loading));
    
    final result = await repository.getPopularMovies(page: _currentPage + 1);
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieListStatus.failure,
        error: failure.message,
      )),
      (movies) {
        _currentPage++;
        emit(state.copyWith(
          status: MovieListStatus.success,
          movies: List.of(state.movies)..addAll(movies),
          hasReachedMax: movies.length < 20,
        ));
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