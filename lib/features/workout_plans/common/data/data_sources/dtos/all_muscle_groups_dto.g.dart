// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_muscle_groups_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllMuscleGroupsDto _$AllMuscleGroupsDtoFromJson(Map<String, dynamic> json) =>
    AllMuscleGroupsDto(
      muscleGroups: (json['muscleGroups'] as List<dynamic>)
          .map((e) => $enumDecode(_$MuscleGroupsEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$AllMuscleGroupsDtoToJson(AllMuscleGroupsDto instance) =>
    <String, dynamic>{
      'muscleGroups':
          instance.muscleGroups.map((e) => _$MuscleGroupsEnumMap[e]!).toList(),
    };

const _$MuscleGroupsEnumMap = {
  MuscleGroups.shouldersAnteriorDelta: 'shoulders_anterior_delta',
  MuscleGroups.biceps: 'biceps',
  MuscleGroups.triceps: 'triceps',
  MuscleGroups.calfMuscle: 'calf_muscle',
  MuscleGroups.latissimusDorsi: 'latissimus_dorsi',
};
