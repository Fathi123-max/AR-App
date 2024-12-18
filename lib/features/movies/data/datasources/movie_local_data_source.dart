import 'package:hive/hive.dart';
import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getFavoriteMovies();
  Future<List<MovieModel>> getWatchlistMovies();
  Future<bool> toggleFavorite(MovieModel movie); // Return bool
  Future<bool> toggleWatchlist(MovieModel movie); // Return bool
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
  Future<bool> toggleFavorite(MovieModel movie) async {
    if (favoriteBox.containsKey(movie.id)) {
      await favoriteBox.delete(movie.id);
      return false; // Not favorite anymore
    } else {
      await favoriteBox.put(movie.id, movie.copyWith(isFavorite: true));
      return true; // Now favorite
    }
  }

  @override
  Future<bool> toggleWatchlist(MovieModel movie) async {
    if (watchlistBox.containsKey(movie.id)) {
      await watchlistBox.delete(movie.id);
      return false; // Not in watchlist anymore
    } else {
      await watchlistBox.put(movie.id, movie.copyWith(isWatchlisted: true));
      return true; // Now in watchlist
    }
  }
}
