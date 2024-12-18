import 'package:get_it/get_it.dart';
import '../../features/movies/data/datasources/movie_local_data_source.dart';
import '../../features/movies/data/datasources/movie_remote_data_source.dart';
import '../../features/movies/data/repositories/movie_repository_impl.dart';
import '../../features/movies/domain/repositories/movie_repository.dart';
import 'modules/database_module.dart';
import 'modules/network_module.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize modules
  await DatabaseModule.init();

  // External dependencies

  // Database boxes
  final favoriteBox = await DatabaseModule.openFavoritesBox();
  final watchlistBox = await DatabaseModule.openWatchlistBox();
  sl.registerLazySingleton<DioService>(() => DioService());
  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      dioLayer: sl<DioService>(),
    ),
  );

  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      favoriteBox: favoriteBox,
      watchlistBox: watchlistBox,
    ),
  );

  // Repositories
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  //
}
