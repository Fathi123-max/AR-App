// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonModelAdapter extends TypeAdapter<PersonModel> {
  @override
  final int typeId = 1;

  @override
  PersonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonModel(
      adult: fields[1] as bool?,
      gender: fields[3] as int?,
      id: fields[5] as int?,
      knownForDepartment: fields[7] as String?,
      name: fields[9] as String?,
      originalName: fields[11] as String?,
      popularity: fields[13] as double?,
      profilePath: fields[15] as String?,
      castId: fields[17] as int?,
      character: fields[19] as String?,
      creditId: fields[21] as String?,
      order: fields[23] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PersonModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.adult)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.knownForDepartment)
      ..writeByte(9)
      ..write(obj.name)
      ..writeByte(11)
      ..write(obj.originalName)
      ..writeByte(13)
      ..write(obj.popularity)
      ..writeByte(15)
      ..write(obj.profilePath)
      ..writeByte(17)
      ..write(obj.castId)
      ..writeByte(19)
      ..write(obj.character)
      ..writeByte(21)
      ..write(obj.creditId)
      ..writeByte(23)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      adult: json['adult'] as bool?,
      gender: (json['gender'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      profilePath: json['profile_path'] as String?,
      castId: (json['cast_id'] as num?)?.toInt(),
      character: json['character'] as String?,
      creditId: json['credit_id'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'cast_id': instance.castId,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
    };
