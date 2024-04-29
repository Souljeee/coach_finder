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
      authorId: json['authorId'] as String?,
      difficulty:
          $enumDecodeNullable(_$DifficultyEnumMap, json['difficulty']) ??
              Difficulty.all,
      muscleGroups: (json['muscleGroups'] as List<dynamic>)
          .map((e) => $enumDecode(_$MuscleGroupsEnumMap, e))
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
      'muscleGroups':
          instance.muscleGroups.map((e) => _$MuscleGroupsEnumMap[e]!).toList(),
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.all: 'all',
};

const _$MuscleGroupsEnumMap = {
  MuscleGroups.shouldersAnteriorDelta: 'shoulders_anterior_delta',
  MuscleGroups.biceps: 'biceps',
  MuscleGroups.triceps: 'triceps',
  MuscleGroups.calfMuscle: 'calf_muscle',
  MuscleGroups.latissimusDorsi: 'latissimus_dorsi',
};
