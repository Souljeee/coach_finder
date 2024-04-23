import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/muscle_groups_enum.dart';
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
        searchExercises: (event) => _onSearchExercises(event, emit),
      ),
    );
  }

  Future<void> _onFetchAllExercises(Emitter<AllExercisesState> emit) async {
    try {
      emit(const AllExercisesState.loading());

      final List responses = await Future.wait([
        _workoutPlanRepository.getAllExercises(),
        _workoutPlanRepository.getAllMuscleGroups(),
      ]);

      final List<ExerciseDto> exercises = responses.first;
      final List<MuscleGroups> muscleGroups = responses.last;

      emit(
        AllExercisesState.success(
          searchedExercises: exercises,
          exercises: exercises,
          muscleGroups: muscleGroups,
        ),
      );
    } catch (e, s) {
      addError(e, s);

      emit(const AllExercisesState.error());
    }
  }

  Future<void> _onSearchExercises(
    _SearchExercisesEvent event,
    Emitter<AllExercisesState> emit,
  ) async {
    state.mapOrNull(
      success: (state) {
        if(event.query == null || event.query!.isEmpty){
          emit(
            AllExercisesState.success(
              searchedExercises: state.exercises,
              exercises: state.exercises,
              muscleGroups: state.muscleGroups,
            ),
          );

          return;
        }

        emit(
          AllExercisesState.success(
            searchedExercises: state.exercises.where(
              (exercise) => exercise.name.toLowerCase().contains(event.query!.toLowerCase()),
            ).toList(),
            exercises: state.exercises,
            muscleGroups: state.muscleGroups,
          ),
        );
      },
    );
  }
}
