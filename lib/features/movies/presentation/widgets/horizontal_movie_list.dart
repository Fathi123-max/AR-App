import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';

class HorizontalMovieList extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final Function(MovieModel) onMovieTap;

  const HorizontalMovieList({
    Key? key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        if (movies.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'No movies found',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        if (movies.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () => onMovieTap(movie),
                  child: Container(
                    width: 130,
                    margin: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: movie.isFavorite
                              ? 'favorite-movie-${movie.id}'
                              : 'watchlist-movie-${movie.id}', // Added 'favorite-' prefix
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              height: 150,
                              width: 130,
                              fit: BoxFit.cover,
                              imageUrl:
                                  '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
