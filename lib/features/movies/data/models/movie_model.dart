import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class MovieModel extends Movie {
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
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
