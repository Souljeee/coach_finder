import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/difficulty_enum.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/muscle_groups_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_dto.g.dart';

@JsonSerializable()
class ExerciseDto{
  final int id;
  final String name;
  final String type;
  final String? description;
  final String? imageUrl;
  final String? videoUrl;
  final String? authorId;
  @JsonKey(defaultValue: Difficulty.all)
  final Difficulty difficulty;
  final List<MuscleGroups> muscleGroups;

  const ExerciseDto({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.authorId,
    required this.difficulty,
    required this.muscleGroups,
  });

  factory ExerciseDto.fromJson(Map<String, dynamic> json) => _$ExerciseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDtoToJson(this);
}