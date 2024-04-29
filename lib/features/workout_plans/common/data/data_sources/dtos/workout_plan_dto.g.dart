// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutPlanDto _$WorkoutPlanDtoFromJson(Map<String, dynamic> json) =>
    WorkoutPlanDto(
      title: json['title'] as String,
      description: json['description'] as String?,
      difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
      authorId: json['authorId'] as String,
      type: json['type'] as String,
      sessionPerWeek: json['sessionPerWeek'] as int,
      planDuration: json['planDuration'] as int,
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutPlanDtoToJson(WorkoutPlanDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'authorId': instance.authorId,
      'type': instance.type,
      'sessionPerWeek': instance.sessionPerWeek,
      'planDuration': instance.planDuration,
      'sessions': instance.sessions,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.all: 'all',
};
