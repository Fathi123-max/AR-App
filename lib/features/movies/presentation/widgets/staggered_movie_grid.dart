import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';

class StaggeredMovieGrid extends StatelessWidget {
  final List<MovieModel> movies;
  final bool isLoading;
  final Function(MovieModel) onMovieTap;
  final VoidCallback onLoadMore;

  const StaggeredMovieGrid({
    Key? key,
    required this.movies,
    required this.isLoading,
    required this.onMovieTap,
    required this.onLoadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.extentAfter == 0) {
          onLoadMore();
        }
        return false;
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: movies.length + (isLoading ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final movie = movies[index];
          return GestureDetector(
            onTap: () => onMovieTap(movie),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'grid-movie-${movie.id}', // Added 'grid-' prefix
                    child: Image.network(
                      '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movie.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
