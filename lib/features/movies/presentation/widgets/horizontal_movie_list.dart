import 'package:flutter/material.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'animated_movie_card.dart';

class HorizontalMovieList extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final Function(MovieModel) onMovieTap;
  final bool showEmptyMessage;

  const HorizontalMovieList({
    Key? key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
    this.showEmptyMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty && !showEmptyMessage) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        if (movies.isEmpty && showEmptyMessage)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'No movies found',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          )
        else
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return AnimatedMovieCard(
                  movie: movie,
                  onTap: () => onMovieTap(movie),
                  isHorizontal: true,
                );
              },
            ),
          ),
      ],
    );
  }
}
