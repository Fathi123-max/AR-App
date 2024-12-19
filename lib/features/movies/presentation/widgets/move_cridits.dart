import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_list_bloc.dart';

class MovieCreditsList extends StatelessWidget {
  final int movieId;

  const MovieCreditsList({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MovieListBloc>().add(GetMovieCredits(movieId));
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Text(
            'credits',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        BlocBuilder<MovieListBloc, MovieListState>(
          buildWhen: (previous, current) =>
              previous.credits != current.credits ||
              previous.status != current.status,
          builder: (context, state) {
            if (state.status == MovieListStatus.loading &&
                state.credits.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == MovieListStatus.failure) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state.credits.isEmpty) {
              return const Center(child: Text('No credits found'));
            } else if (state.credits.isNotEmpty) {
              return SizedBox(
                height: 200, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.credits.length,
                  itemBuilder: (context, index) {
                    final person = state.credits[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: person.profilePath != null
                                ? CachedNetworkImageProvider(
                                    '${ApiConstants.imageBaseUrl}${person.profilePath}',
                                  )
                                : null,
                            child: person.profilePath == null
                                ? const Icon(Icons.person, size: 40)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            person.name ?? 'N/A',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink(); // or a placeholder widget
            }
          },
        ),
      ],
    );
  }
}
