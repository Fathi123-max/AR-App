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
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.metrics.pixels ==
                    scrollNotification.metrics.maxScrollExtent) {
              final state = context.read<MovieListBloc>().state;
              if (!state.hasReachedMax) {
                context.read<MovieListBloc>().add(const LoadMoreMovies());
              }
            }
            return false;
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "All Movies",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocConsumer<MovieListBloc, MovieListState>(
                  listener: (context, state) =>
                      state.status == MovieListStatus.failure
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error!),
                              ),
                            )
                          : null,
                  listenWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    if (state.status == MovieListStatus.initial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.hasReachedMax) {
                      return const Center(
                          child: Text('No more movies to load.'));
                    }

                    return AdGridView(
                      adIndex: 10,
                      crossAxisCount: 2,
                      adGridViewType: AdGridViewType.repeated,
                      adWidget: _buildHorizontalMovieList(state, context),
                      itemCount: state.movies.length,
                      itemWidget: (context, index) =>
                          _buildMovieCard(state.movies[index], context),
                    );
                  },
                ),
              ),
            ],
          ),
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
