import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PersonModel {
  @HiveField(1)
  @JsonKey(name: "adult")
  bool? adult;
  @HiveField(3)
  @JsonKey(name: "gender")
  int? gender;
  @HiveField(5)
  @JsonKey(name: "id")
  int? id;
  @HiveField(7)
  @JsonKey(name: "known_for_department")
  String? knownForDepartment;
  @HiveField(9)
  @JsonKey(name: "name")
  String? name;
  @HiveField(11)
  @JsonKey(name: "original_name")
  String? originalName;
  @HiveField(13)
  @JsonKey(name: "popularity")
  double? popularity;
  @HiveField(15)
  @JsonKey(name: "profile_path")
  String? profilePath;
  @HiveField(17)
  @JsonKey(name: "cast_id")
  int? castId;
  @HiveField(19)
  @JsonKey(name: "character")
  String? character;
  @HiveField(21)
  @JsonKey(name: "credit_id")
  String? creditId;
  @HiveField(23)
  @JsonKey(name: "order")
  int? order;

  PersonModel({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}
