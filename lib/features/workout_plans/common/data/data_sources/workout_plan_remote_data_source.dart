import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/all_muscle_groups_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/workout_plan_dto.dart';
import 'package:dio/dio.dart';

class WorkoutPlanRemoteDataSource {
  final Dio _networkClient;

  const WorkoutPlanRemoteDataSource({required Dio networkClient}) : _networkClient = networkClient;

  Future<List<ExerciseDto>> getAllExercises() async {
    final response = await _networkClient.get('/exercises_list');

    return response.data
        .map<ExerciseDto>(
          (exercise) => ExerciseDto.fromJson(exercise),
        )
        .toList();
  }

  Future<AllMuscleGroupsDto> getAllMuscleGroups() async {
    final response = await _networkClient.get('/all_muscle_groups');

    return AllMuscleGroupsDto.fromJson(response.data);
  }

  Future<void> createWorkoutPlan({required WorkoutPlanDto workoutPlanDto}) async {
    await _networkClient.post(
      '/create_workout_plan',
      data: workoutPlanDto.toJson(),
    );
  }
}
