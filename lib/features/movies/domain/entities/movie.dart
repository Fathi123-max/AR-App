// import 'package:equatable/equatable.dart';

// class MovieModel extends Equatable {
//   bool? adult;
//   String? backdropPath;
//   List<int>? genreIds;
//   int? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   DateTime? releaseDate;
//   String? title;
//   bool? video;
//   int? voteAverage;
//   int? voteCount;
//   bool? isFavorite;

//   bool? isWatchlisted;

//   MovieModel(
//       {this.adult,
//       this.backdropPath,
//       this.genreIds,
//       this.id,
//       this.originalLanguage,
//       this.originalTitle,
//       this.overview,
//       this.popularity,
//       this.posterPath,
//       this.releaseDate,
//       this.title,
//       this.video,
//       this.voteAverage,
//       this.voteCount,
//       this.isWatchlisted,
//       this.isFavorite});

//   MovieModel copyWith(
//           {bool? adult,
//           String? backdropPath,
//           List<int>? genreIds,
//           int? id,
//           String? originalLanguage,
//           String? originalTitle,
//           String? overview,
//           double? popularity,
//           String? posterPath,
//           DateTime? releaseDate,
//           String? title,
//           bool? video,
//           int? voteAverage,
//           int? voteCount,
//           bool? isWatchlisted,
//           bool? isFavorite}) =>
//       MovieModel(
//           adult: adult ?? this.adult,
//           backdropPath: backdropPath ?? this.backdropPath,
//           genreIds: genreIds ?? this.genreIds,
//           id: id ?? this.id,
//           originalLanguage: originalLanguage ?? this.originalLanguage,
//           originalTitle: originalTitle ?? this.originalTitle,
//           overview: overview ?? this.overview,
//           popularity: popularity ?? this.popularity,
//           posterPath: posterPath ?? this.posterPath,
//           releaseDate: releaseDate ?? this.releaseDate,
//           title: title ?? this.title,
//           video: video ?? this.video,
//           voteAverage: voteAverage ?? this.voteAverage,
//           voteCount: voteCount ?? this.voteCount,
//           isWatchlisted: isWatchlisted ?? this.isWatchlisted,
//           isFavorite: isFavorite ?? this.isFavorite);

//   @override
//   List<Object?> get props => [
//         adult,
//         backdropPath,
//         genreIds,
//         id,
//         originalLanguage,
//         originalTitle,
//         overview,
//         popularity,
//         posterPath,
//         releaseDate,
//         title,
//         video,
//         voteAverage,
//         voteCount,
//         isFavorite,
//         isWatchlisted
//       ];
// }
