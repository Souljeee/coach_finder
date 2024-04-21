import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/workout_plan_remote_data_source.dart';

class WorkoutPlanRepository {
  final WorkoutPlanRemoteDataSource _workoutPlanRemoteDataSource;

  const WorkoutPlanRepository({
    required WorkoutPlanRemoteDataSource workoutPlanRemoteDataSource,
  }) : _workoutPlanRemoteDataSource = workoutPlanRemoteDataSource;

  Future<List<ExerciseDto>> getAllExercises() async {
    return _workoutPlanRemoteDataSource.getAllExercises();
  }
}
