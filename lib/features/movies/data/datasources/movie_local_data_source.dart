import 'package:hive/hive.dart';
import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getFavoriteMovies();
  Future<List<MovieModel>> getWatchlistMovies();
  Future<void> toggleFavorite(MovieModel movie);
  Future<void> toggleWatchlist(MovieModel movie);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final Box<MovieModel> favoriteBox;
  final Box<MovieModel> watchlistBox;

  MovieLocalDataSourceImpl({
    required this.favoriteBox,
    required this.watchlistBox,
  });

  @override
  Future<List<MovieModel>> getFavoriteMovies() async {
    return favoriteBox.values.toList();
  }

  @override
  Future<List<MovieModel>> getWatchlistMovies() async {
    return watchlistBox.values.toList();
  }

  @override
  Future<void> toggleFavorite(MovieModel movie) async {
    if (favoriteBox.containsKey(movie.id)) {
      await favoriteBox.delete(movie.id);
    } else {
      await favoriteBox.put(movie.id, movie);
    }
  }

  @override
  Future<void> toggleWatchlist(MovieModel movie) async {
    if (watchlistBox.containsKey(movie.id)) {
      await watchlistBox.delete(movie.id);
    } else {
      await watchlistBox.put(movie.id, movie);
    }
  }
}