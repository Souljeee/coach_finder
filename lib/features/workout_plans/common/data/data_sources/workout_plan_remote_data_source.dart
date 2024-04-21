import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_dto.dart';
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
}
