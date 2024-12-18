import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  /// Get popular movies with pagination
  Future<Either<Failure, List<Movie>>> getPopularMovies({required int page});
  
  /// Get movie details by ID
  Future<Either<Failure, Movie>> getMovieDetails(int id);
  
  /// Get favorite movies
  Future<Either<Failure, List<Movie>>> getFavoriteMovies();
  
  /// Get watchlist movies
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
  
  /// Toggle favorite status
  Future<Either<Failure, bool>> toggleFavorite(Movie movie);
  
  /// Toggle watchlist status
  Future<Either<Failure, bool>> toggleWatchlist(Movie movie);
}