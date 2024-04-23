import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/muscle_groups_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_muscle_groups_dto.g.dart';

@JsonSerializable()
class AllMuscleGroupsDto{
  final List<MuscleGroups> muscleGroups;
  const AllMuscleGroupsDto({required this.muscleGroups});

  factory AllMuscleGroupsDto.fromJson(Map<String, dynamic> json) => _$AllMuscleGroupsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AllMuscleGroupsDtoToJson(this);
}