import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/repositories/workout_plan_repository.dart';
import 'package:equatable/equatable.dart';

part 'all_exercises_event.dart';

part 'all_exercises_state.dart';

class AllExercisesBloc extends Bloc<AllExercisesEvent, AllExercisesState> {
  final WorkoutPlanRepository _workoutPlanRepository;

  AllExercisesBloc({
    required WorkoutPlanRepository workoutPlanRepository,
  })  : _workoutPlanRepository = workoutPlanRepository,
        super(const AllExercisesState.loading()) {
    on<AllExercisesEvent>(
      (event, emit) => event.map(
        fetchAllExercises: (event) => _onFetchAllExercises(emit),
      ),
    );
  }

  Future<void> _onFetchAllExercises(Emitter<AllExercisesState> emit) async {
    try {
      emit(const AllExercisesState.loading());

      final List<ExerciseDto> exercises = await _workoutPlanRepository.getAllExercises();

      emit(AllExercisesState.success(exercises: exercises));
    } catch (e, s) {
      addError(e, s);

      emit(const AllExercisesState.error());
    }
  }
}
