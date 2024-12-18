import 'package:ad_gridview/ad_gridview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import '../bloc/movie_list_bloc.dart';
import '../widgets/horizontal_movie_list.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<MovieListBloc>().add(const LoadMovies());
          context.read<MovieListBloc>().add(const LoadFavorites());
          context.read<MovieListBloc>().add(const LoadWatchlist());
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  return HorizontalMovieList(
                    title: 'Favorites',
                    movies: state.favoriteMovies,
                    onMovieTap: (movie) => Navigator.pushNamed(
                      context,
                      '/movie-details',
                      arguments: movie,
                    ),
                  );
                },
              ),
            ),
            SliverFillRemaining(
              child: BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state.status == MovieListStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == MovieListStatus.failure) {
                    return Center(
                      child: Text(state.error ?? 'Something went wrong'),
                    );
                  }

                  if (state.hasReachedMax) {
                    return const Center(child: Text('No more movies to load.'));
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.metrics.pixels ==
                              scrollNotification.metrics.maxScrollExtent) {
                        if (!state.hasReachedMax) {
                          context
                              .read<MovieListBloc>()
                              .add(const LoadMoreMovies());
                        }
                      }
                      return false;
                    },
                    child: AdGridView(
                      crossAxisCount: 2,
                      adGridViewType: AdGridViewType.repeated,
                      adIndex: 10,
                      adWidget: _buildHorizontalMovieList(state, context),
                      itemCount: state.movies.length,
                      itemWidget: (context, index) =>
                          _buildMovieCard(state.movies[index], context),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // Extracted method to build HorizontalMovieList widget
  Widget _buildHorizontalMovieList(MovieListState state, BuildContext context) {
    return HorizontalMovieList(
      title: 'Waitless Movies',
      movies: state.watchlistMovies,
      onMovieTap: (movie) => Navigator.pushNamed(
        context,
        '/movie-details',
        arguments: movie,
      ),
    );
  }

// Extracted method to build individual movie card widget
  Widget _buildMovieCard(MovieModel movie, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/movie-details',
        arguments: movie,
      ),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
