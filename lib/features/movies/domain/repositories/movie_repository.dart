import 'package:dartz/dartz.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/data/models/person_model.dart';
import '../../../../core/error/failures.dart';

abstract class MovieRepository {
  /// Get popular movies with pagination
  Future<Either<Failure, List<MovieModel>>> getPopularMovies(
      {required int page});

  /// Get movie credits by ID
  Future<Either<Failure, List<PersonModel>>> getMovieCredits(int movieId);

  /// Get movie details by ID
  Future<Either<Failure, MovieModel>> getMovieDetails(int id);

  /// Get favorite movies
  Future<Either<Failure, List<MovieModel>>> getFavoriteMovies();

  /// Get watchlist movies
  Future<Either<Failure, List<MovieModel>>> getWatchlistMovies();

  /// Toggle favorite status
  Future<Either<Failure, bool>> toggleFavorite(MovieModel movie);

  /// Toggle watchlist status
  Future<Either<Failure, bool>> toggleWatchlist(MovieModel movie);
}
