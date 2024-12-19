import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import '../../features/movies/data/datasources/movie_local_data_source.dart';
import '../../features/movies/data/datasources/movie_remote_data_source.dart';
import '../../features/movies/data/repositories/movie_repository_impl.dart';
import '../../features/movies/domain/repositories/movie_repository.dart';
import 'modules/database_module.dart';
import 'modules/network_module.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  sl.registerLazySingleton<DioService>(() => DioService());
  // Initialize Hive
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  if (!Hive.isAdapterRegistered(MovieModelAdapter().typeId)) {
    Hive.registerAdapter(MovieModelAdapter());
  }

  // Database boxes
  final favoriteBox = await DatabaseModule.openFavoritesBox();
  final watchlistBox = await DatabaseModule.openWatchlistBox();

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
}
