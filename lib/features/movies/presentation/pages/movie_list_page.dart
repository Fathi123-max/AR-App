import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_list_bloc.dart';
import '../widgets/horizontal_movie_list.dart';
import '../widgets/staggered_movie_grid.dart';

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

                  return StaggeredMovieGrid(
                    movies: state.movies,
                    isLoading: state.status == MovieListStatus.loading,
                    onMovieTap: (movie) => Navigator.pushNamed(
                      context,
                      '/movie-details',
                      arguments: movie,
                    ),
                    onLoadMore: () {
                      if (!state.hasReachedMax) {
                        context.read<MovieListBloc>().add(const LoadMoreMovies());
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}