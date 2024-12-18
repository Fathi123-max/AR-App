import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movies/presentation/widgets/animated_watchlist_button.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/movie.dart';
import '../widgets/animated_favorite_button.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'movie-${movie.id}',
                child: CachedNetworkImage(
                  imageUrl: '${ApiConstants.imageBaseUrl}${movie.backdropPath}',
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
                          AnimatedFavoriteButton(
                            isFavorite: movie.isFavorite ?? false,
                            onPressed: () {
                              // TODO: Implement favorite toggle
                            },
                          ),
                          AnimatedWatchlistButton(
                            isWatchlisted: movie.isWatchlisted ?? false,
                            onPressed: () {
                              // TODO: Implement watchlist toggle
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
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
