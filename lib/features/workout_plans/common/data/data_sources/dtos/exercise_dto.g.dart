// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseDto _$ExerciseDtoFromJson(Map<String, dynamic> json) => ExerciseDto(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      authorId: json['authorId'] as String,
      difficulty:
          $enumDecodeNullable(_$DifficultyEnumMap, json['difficulty']) ??
              Difficulty.all,
      muscleGroups: (json['muscleGroups'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExerciseDtoToJson(ExerciseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'authorId': instance.authorId,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'muscleGroups': instance.muscleGroups,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'coach',
  Difficulty.medium: 'client',
  Difficulty.hard: 'hard',
  Difficulty.all: 'all',
};
