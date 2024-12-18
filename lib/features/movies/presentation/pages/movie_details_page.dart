import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/core/di/injection_container.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_list_bloc.dart';
import 'package:movie_app/features/movies/presentation/widgets/animated_watchlist_button.dart';
import '../../../../core/constants/api_constants.dart';
import '../widgets/animated_favorite_button.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFromFavorites =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () => Navigator.pop(context),
            ),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: isFromFavorites
                    ? 'favorite-movie-${movie.id}'
                    : 'grid-movie-${movie.id}',
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie.title ?? "",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Row(
                        children: [
                          // For Favorite Button
                          BlocBuilder<MovieListBloc, MovieListState>(
                            buildWhen: (p, c) =>
                                p.favoriteMovies != c.favoriteMovies ||
                                p.movies != c.movies,
                            builder: (context, state) {
                              final isFavorite = state.favoriteMovies
                                  .any((m) => m.id == movie.id);
                              return AnimatedFavoriteButton(
                                isFavorite: isFavorite,
                                onPressed: () {
                                  context
                                      .read<MovieListBloc>()
                                      .add(ToggleFavorite(movie));
                                },
                              );
                            },
                          ),

// For Watchlist Button
                          BlocBuilder<MovieListBloc, MovieListState>(
                            buildWhen: (p, c) =>
                                p.watchlistMovies != c.watchlistMovies ||
                                p.movies != c.movies,
                            builder: (context, state) {
                              final isWatchlisted = state.watchlistMovies
                                  .any((m) => m.id == movie.id);
                              return AnimatedWatchlistButton(
                                isWatchlisted: isWatchlisted,
                                onPressed: () {
                                  context
                                      .read<MovieListBloc>()
                                      .add(ToggleWatchlist(movie));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.voteAverage!.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        movie.releaseDate!.year.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
