import 'package:coach_finder/features/workout_plans/common/ui/models/exercise_model.dart';

class SessionModel{
  final int orderNumber;
  final String type;
  final int duration;
  final List<ExerciseModel> exercises;

  const SessionModel({
    required this.orderNumber,
    required this.type,
    required this.duration,
    required this.exercises,
  });
}