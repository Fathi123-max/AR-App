import 'package:movie_app/core/di/modules/network_module.dart';
import 'package:movie_app/features/movies/data/models/person_model.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failures.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getDocumentMovies(int page);
  Future<MovieModel> getMovieDetails(int id);
  Future<List<PersonModel>> getMovieCredits(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioService dioLayer;

  MovieRemoteDataSourceImpl({required this.dioLayer});
  @override
  Future<List<MovieModel>> getDocumentMovies(int page) async {
    final response = await dioLayer.get(
        '${ApiConstants.baseUrl}${ApiConstants.searchMovies}',
        queryParameters: {
          'query': 'war',
          'include_adult': false,
          'language': 'en-US',
          'page': page,
          'primary_release_year': '1970',
          'region': 'sa',
        });

    final results = response.data['results'] as List;
    return results.map((movie) {
      return MovieModel.fromJson(movie);
    }).toList();
  }

  @override
  Future<MovieModel> getMovieDetails(int id) async {
    try {
      final response = await dioLayer.get(
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

  @override
  Future<List<PersonModel>> getMovieCredits(int movieId) async {
    try {
      final response = await dioLayer.get(
        '${ApiConstants.baseUrl}${ApiConstants.movieCredits(movieId)}',
      );

      if (response.statusCode == 200) {
        final data =
            response.data['cast'] as List; // Cast response data to List
        return data
            .map((personData) => PersonModel.fromJson(personData))
            .toList();
      } else {
        throw const ServerFailure('Failed to fetch movie credits');
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
