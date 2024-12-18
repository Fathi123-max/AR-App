import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/movies/presentation/bloc/movie_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MovieListBloc(repository: di.sl())
          ..add(const LoadMovies())
          ..add(const LoadFavorites())
          ..add(const LoadWatchlist()),
        child: MaterialApp(
          title: 'Movie App',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ));
  }
}
