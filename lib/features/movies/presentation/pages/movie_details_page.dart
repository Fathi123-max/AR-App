import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_list_bloc.dart';
import 'package:movie_app/features/movies/presentation/widgets/animated_watchlist_button.dart';
import 'package:movie_app/features/movies/presentation/widgets/move_cridits.dart';
import '../widgets/animated_favorite_button.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // Optimize scroll performance
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleRow(context),
                  _buildMetadataRow(context),
                  _buildOverviewSection(context),
                  MovieCreditsList(movieId: movie.id!)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final String heroTag = movie.isFavorite
        ? 'favorite-movie-${movie.id}'
        : movie.isWatchlisted
            ? 'watchlist-movie-${movie.id}'
            : 'grid-movie-${movie.id}';

    return SliverAppBar(
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Navigator.pop(context),
      ),
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.imageBaseUrl}${movie.posterPath}',
            fit: BoxFit.cover,
            // Add placeholder and error widgets
            placeholder: (context, url) => const ColoredBox(
              color: Colors.grey,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => const ColoredBox(
              color: Colors.grey,
              child: Icon(Icons.error),
            ),
            // Enable memory caching
            memCacheWidth: 600,
            memCacheHeight: 900,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            movie.title ?? "",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const _ActionButtons(),
      ],
    );
  }

  Widget _buildMetadataRow(BuildContext context) {
    return Row(
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
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }
}

// Separate stateless widget for action buttons to optimize rebuilds
class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocSelector<MovieListBloc, MovieListState, bool>(
          selector: (state) => state.favoriteMovies.any((m) =>
              m.id ==
              context
                  .findAncestorWidgetOfExactType<MovieDetailsPage>()
                  ?.movie
                  .id),
          builder: (context, isFavorite) {
            return AnimatedFavoriteButton(
              isFavorite: isFavorite,
              onPressed: () {
                final movie = context
                    .findAncestorWidgetOfExactType<MovieDetailsPage>()
                    ?.movie;
                if (movie != null) {
                  context.read<MovieListBloc>().add(ToggleFavorite(movie));
                }
              },
            );
          },
        ),
        BlocSelector<MovieListBloc, MovieListState, bool>(
          selector: (state) => state.watchlistMovies.any((m) =>
              m.id ==
              context
                  .findAncestorWidgetOfExactType<MovieDetailsPage>()
                  ?.movie
                  .id),
          builder: (context, isWatchlisted) {
            return AnimatedWatchlistButton(
              isWatchlisted: isWatchlisted,
              onPressed: () {
                final movie = context
                    .findAncestorWidgetOfExactType<MovieDetailsPage>()
                    ?.movie;
                if (movie != null) {
                  context.read<MovieListBloc>().add(ToggleWatchlist(movie));
                }
              },
            );
          },
        ),
      ],
    );
  }
}
