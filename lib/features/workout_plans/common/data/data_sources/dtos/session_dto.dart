import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_details_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto{
  final int orderNumber;
  final String type;
  final int duration;
  final List<ExerciseDetailsDto> exercises;

  const SessionDto({
    required this.orderNumber,
    required this.type,
    required this.duration,
    required this.exercises,
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) => _$SessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);
}