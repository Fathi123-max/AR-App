import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/movies/presentation/bloc/movie_list_bloc.dart';

void main() async {
  // Initialize the widgets binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the app's dependencies
  await di.initializeDependencies();

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap with BlocProvider to provide the MovieListBloc to the entire app

    return BlocProvider(
        create: (_) => MovieListBloc(repository: di.sl())
          ..add(const LoadMovies())
          ..add(const LoadFavorites())
          ..add(const LoadWatchlist()),
        child: MaterialApp(
          title: 'Movie App',
          theme: AppTheme.light,
          themeMode: ThemeMode.system,
          darkTheme: AppTheme.dark,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ));
  }
}
