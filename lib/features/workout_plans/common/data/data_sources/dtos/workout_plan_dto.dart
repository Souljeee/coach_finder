import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/difficulty_enum.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/muscle_groups_enum.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/session_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_plan_dto.g.dart';

@JsonSerializable()
class WorkoutPlanDto{
  final String title;
  final String? description;
  final Difficulty difficulty;
  final String authorId;
  final String type;
  final int sessionPerWeek;
  final int planDuration;
  final List<SessionDto> sessions;

  const WorkoutPlanDto({
    required this.title,
    required this.description,
    required this.difficulty,
    required this.authorId,
    required this.type,
    required this.sessionPerWeek,
    required this.planDuration,
    required this.sessions,
  });

  factory WorkoutPlanDto.fromJson(Map<String, dynamic> json) => _$WorkoutPlanDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutPlanDtoToJson(this);
}