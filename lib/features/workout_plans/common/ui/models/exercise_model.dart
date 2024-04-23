import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/difficulty_enum.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/muscle_groups_enum.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/approach_model.dart';

class ExerciseModel{
  final int id;
  final String name;
  final String type;
  final String? description;
  final String? imageUrl;
  final String? videoUrl;
  final String? authorId;

  final Difficulty difficulty;
  final List<MuscleGroups> muscleGroups;

  final int orderNumber;
  final String? comment;
  final List<ApproachModel> approaches;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.authorId,
    required this.difficulty,
    required this.muscleGroups,
    required this.orderNumber,
    required this.comment,
    required this.approaches,
  });
}