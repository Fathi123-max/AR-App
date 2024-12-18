import 'package:movie_app/core/di/modules/dio_network_layer.dart';
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

      if (response.statusCode == 200) {
        final results = response.data['results'] as List;
        return results.map((movie) {
          return MovieModel.fromJson(movie);
        }).toList();
      } else {
        throw ServerFailure('Failed to fetch popular movies');
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
        throw ServerFailure('Failed to fetch movie details');
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
