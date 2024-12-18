import 'package:flutter/material.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import '../../features/movies/presentation/pages/movie_details_page.dart';
import '../../features/movies/presentation/pages/movie_list_page.dart';

class AppRouter {
  static const String home = '/';
  static const String movieDetails = '/movie-details';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const MovieListPage(),
        );
      case movieDetails:
        final movie = settings.arguments as MovieModel;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MovieDetailsPage(
            movie: movie,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
