import 'package:dio/dio.dart';
import 'package:movie_app/core/di/modules/network_module.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failures.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getDocumentMovies(int page);
  Future<MovieModel> getMovieDetails(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioService dioLayer;

  MovieRemoteDataSourceImpl({required this.dioLayer});
  @override
  Future<List<MovieModel>> getDocumentMovies(int page) async {
    try {
      final response = await dioLayer.dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.popularMovies}',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
          'page': page,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 304) {
        final results = response.data['results'] as List;
        return results.map((movie) {
          return MovieModel.fromJson(movie);
        }).toList();
      } else if (response.statusCode == 401) {
        throw const ServerFailure('Api key is invalid or expired');
      } else if (response.statusCode == 404) {
        throw const ServerFailure('Movie not found');
      } else if (response.statusCode == 422) {
        throw const ServerFailure('Validation failed');
      } else if (response.statusCode == 429) {
        throw const ServerFailure('Too many requests');
      } else if (response.statusCode! >= 500) {
        throw const ServerFailure('Server failed to process your request');
      } else {
        throw const ServerFailure('Failed to fetch popular movies');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const ServerFailure('Connection timed out');
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw const ServerFailure('Send request timed out');
      } else if (e.type == DioExceptionType.cancel) {
        throw const ServerFailure('Request cancelled');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const ServerFailure('Network connection lost');
      } else {
        throw ServerFailure(e.toString());
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<MovieModel> getMovieDetails(int id) async {
    try {
      final response = await dioLayer.dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.movieDetails}$id',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.data);
      } else {
        throw const ServerFailure('Failed to fetch movie details');
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
