import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/presentation/widgets/shimmer_placeholder.dart';
import 'animated_movie_card.dart';

class StaggeredMovieGrid extends StatelessWidget {
  final List<MovieModel> movies;
  final Function(MovieModel) onMovieTap;
  final bool isLoading;
  final VoidCallback? onLoadMore;

  const StaggeredMovieGrid({
    Key? key,
    required this.movies,
    required this.onMovieTap,
    this.isLoading = false,
    this.onLoadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            onLoadMore != null) {
          onLoadMore!();
        }
        return true;
      },
      child: AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: movies.length + (isLoading ? 2 : 0),
          itemBuilder: (context, index) {
            if (index >= movies.length) {
              return const ShimmerPlaceholder();
            }

            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: AnimatedMovieCard(
                    movie: movies[index],
                    onTap: () => onMovieTap(movies[index]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
