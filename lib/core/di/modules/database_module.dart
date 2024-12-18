import 'package:hive_flutter/hive_flutter.dart';
import '../../../features/movies/data/models/movie_model.dart';

class DatabaseModule {
  static Future<void> init() async {
    // await Hive.initFlutter();
    // Hive.registerAdapter(MovieModelAdapter());
  }

  static Future<Box<MovieModel>> openFavoritesBox() async {
    try {
      // Log the attempt to open the favorites box
      print("Attempting to open the favorites box...");

      bool isOpen = Hive.isBoxOpen('favorites');

      if (!isOpen) {
        print("Favorites box is not open. Opening now...");
        return await Hive.openBox<MovieModel>('favorites');
      }

      print("Favorites box is already open.");
      return Hive.box<MovieModel>('favorites');
    } catch (e) {
      print("Error opening favorites box: $e");
      rethrow;
    }
  }

  static Future<Box<MovieModel>> openWatchlistBox() async {
    try {
      if (!Hive.isBoxOpen('watchlist')) {
        return await Hive.openBox<MovieModel>('watchlist');
      }
      return Hive.box<MovieModel>('watchlist');
    } catch (e) {
      // Add error handling or logging as needed
      rethrow;
    }
  }
}
