import 'package:dartz/dartz.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/movie.dart';
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
  Future<Either<Failure, List<Movie>>> getPopularMovies(
      {required int page}) async {
    try {
      final movies = await remoteDataSource.getDocumentMovies(page);
      return Right(movies);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetails(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetails(id);
      return Right(movie);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavoriteMovies() async {
    try {
      final movies = await localDataSource.getFavoriteMovies();
      return Right(movies);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    try {
      final movies = await localDataSource.getWatchlistMovies();
      return Right(movies);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(Movie movie) async {
    try {
      await localDataSource.toggleFavorite(movie as MovieModel);
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleWatchlist(Movie movie) async {
    try {
      await localDataSource.toggleWatchlist(movie as MovieModel);
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
