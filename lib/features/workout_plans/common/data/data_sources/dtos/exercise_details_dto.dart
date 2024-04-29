import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/approach_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_details_dto.g.dart';

@JsonSerializable()
class ExerciseDetailsDto{
  final int exerciseId;
  final String? comment;
  final int orderNumber;
  final List<ApproachDto> approaches;

  const ExerciseDetailsDto({
    required this.exerciseId,
    required this.comment,
    required this.orderNumber,
    required this.approaches,
  });

  factory ExerciseDetailsDto.fromJson(Map<String, dynamic> json) => _$ExerciseDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDetailsDtoToJson(this);
}