// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 33;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      adult: fields[1] as bool?,
      backdropPath: fields[3] as String?,
      genreIds: (fields[5] as List?)?.cast<int>(),
      id: fields[7] as int?,
      originalLanguage: fields[9] as String?,
      originalTitle: fields[11] as String?,
      overview: fields[13] as String?,
      popularity: fields[15] as double?,
      posterPath: fields[17] as String?,
      releaseDate: fields[19] as DateTime?,
      title: fields[21] as String?,
      video: fields[23] as bool?,
      voteAverage: fields[25] as double?,
      voteCount: fields[27] as int?,
      isFavorite: fields[29] as bool,
      isWatchlisted: fields[30] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(1)
      ..write(obj.adult)
      ..writeByte(3)
      ..write(obj.backdropPath)
      ..writeByte(5)
      ..write(obj.genreIds)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.originalLanguage)
      ..writeByte(11)
      ..write(obj.originalTitle)
      ..writeByte(13)
      ..write(obj.overview)
      ..writeByte(15)
      ..write(obj.popularity)
      ..writeByte(17)
      ..write(obj.posterPath)
      ..writeByte(19)
      ..write(obj.releaseDate)
      ..writeByte(21)
      ..write(obj.title)
      ..writeByte(23)
      ..write(obj.video)
      ..writeByte(25)
      ..write(obj.voteAverage)
      ..writeByte(27)
      ..write(obj.voteCount)
      ..writeByte(29)
      ..write(obj.isFavorite)
      ..writeByte(30)
      ..write(obj.isWatchlisted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num?)?.toInt(),
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      isFavorite: json['isFavorite'] as bool? ?? false,
      isWatchlisted: json['isWatchlisted'] as bool? ?? false,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'isFavorite': instance.isFavorite,
      'isWatchlisted': instance.isWatchlisted,
    };
