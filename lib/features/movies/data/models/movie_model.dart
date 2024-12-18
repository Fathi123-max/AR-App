import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 33)
@JsonSerializable()
class MovieModel {
  @override
  @HiveField(1)
  @JsonKey(name: "adult")
  bool? adult;
  @override
  @HiveField(3)
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @override
  @HiveField(5)
  @JsonKey(name: "genre_ids")
  List<int>? genreIds;
  @override
  @HiveField(7)
  @JsonKey(name: "id")
  int? id;
  @override
  @HiveField(9)
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @override
  @HiveField(11)
  @JsonKey(name: "original_title")
  String? originalTitle;
  @override
  @HiveField(13)
  @JsonKey(name: "overview")
  String? overview;
  @override
  @HiveField(15)
  @JsonKey(name: "popularity")
  double? popularity;
  @override
  @HiveField(17)
  @JsonKey(name: "poster_path")
  String? posterPath;
  @override
  @HiveField(19)
  @JsonKey(name: "release_date")
  DateTime? releaseDate;
  @override
  @HiveField(21)
  @JsonKey(name: "title")
  String? title;
  @override
  @HiveField(23)
  @JsonKey(name: "video")
  bool? video;
  @override
  @HiveField(25)
  @JsonKey(name: "vote_average")
  int? voteAverage;
  @override
  @HiveField(27)
  @JsonKey(name: "vote_count")
  int? voteCount;
  //isFavorite
  @HiveField(29)
  bool isFavorite = false;
  //isWatchlisted
  @HiveField(30)
  bool isWatchlisted = false;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.isFavorite = false,
    this.isWatchlisted = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  MovieModel copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    int? voteAverage,
    int? voteCount,
    bool? isFavorite,
    bool? isWatchlisted,
  }) {
    return MovieModel(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      isFavorite: isFavorite ?? this.isFavorite,
      isWatchlisted: isWatchlisted ?? this.isWatchlisted,
    );
  }
}
