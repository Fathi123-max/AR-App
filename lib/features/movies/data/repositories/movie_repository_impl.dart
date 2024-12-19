import 'package:dartz/dartz.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/data/models/person_model.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies(
      {required int page}) async {
    try {
      final movies = await remoteDataSource.getDocumentMovies(page);
      return Right(movies);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieModel>> getMovieDetails(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetails(id);
      return Right(movie);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getFavoriteMovies() async {
    try {
      final movies = await localDataSource.getFavoriteMovies();
      return Right(movies);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getWatchlistMovies() async {
    try {
      final movies = await localDataSource.getWatchlistMovies();
      return Right(movies);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(MovieModel movie) async {
    try {
      final isNowFavorite = await localDataSource.toggleFavorite(movie);
      return Right(isNowFavorite);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleWatchlist(MovieModel movie) async {
    try {
      final isNowWatchlisted = await localDataSource.toggleWatchlist(movie);
      return Right(isNowWatchlisted);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PersonModel>>> getMovieCredits(
      int movieId) async {
    try {
      final credits = await remoteDataSource.getMovieCredits(movieId);
      return Right(credits);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
