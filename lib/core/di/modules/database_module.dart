import 'package:hive_flutter/hive_flutter.dart';
import '../../../features/movies/data/models/movie_model.dart';

class DatabaseModule {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieModelAdapter());
  }

  static Future<Box<MovieModel>> openFavoritesBox() async {
    return await Hive.openBox<MovieModel>('favorites');
  }

  static Future<Box<MovieModel>> openWatchlistBox() async {
    return await Hive.openBox<MovieModel>('watchlist');
  }
}