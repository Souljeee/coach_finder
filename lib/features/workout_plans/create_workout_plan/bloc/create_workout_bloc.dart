import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/features/profile/data/data_sources/dtos/user_dto.dart';
import 'package:coach_finder/features/profile/data/repositories/user_repository.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/approach_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/difficulty_enum.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_details_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/session_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/workout_plan_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/repositories/workout_plan_repository.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/session_model.dart';
import 'package:equatable/equatable.dart';

part 'create_workout_event.dart';

part 'create_workout_state.dart';

class CreateWorkoutBloc extends Bloc<CreateWorkoutEvent, CreateWorkoutState> {
  final WorkoutPlanRepository _workoutPlanRepository;
  final UserRepository _userRepository;

  CreateWorkoutBloc({
    required WorkoutPlanRepository workoutPlanRepository,
    required UserRepository userRepository,
  })  : _workoutPlanRepository = workoutPlanRepository,
        _userRepository = userRepository,
        super(const CreateWorkoutState.idle()) {
    on<CreateWorkoutEvent>(
      (event, emit) => event.map(
        createWorkoutPlan: (event) => _onCreateWorkoutPlan(event, emit),
      ),
    );
  }

  Future<void> _onCreateWorkoutPlan(
    _CreateWorkoutPlanEvent event,
    Emitter<CreateWorkoutState> emit,
  ) async {
    try {
      emit(const CreateWorkoutState.loading());

      final UserDto user = await _userRepository.getUser();

      await _workoutPlanRepository.createWorkoutPlan(
        workoutPlanDto: WorkoutPlanDto(
          title: event.title,
          description: event.description,
          difficulty: event.difficulty,
          authorId: user.id,
          type: event.type,
          sessionPerWeek: event.sessionsPerWeek,
          planDuration: event.planDuration,
          sessions: event.sessions
              .map(
                (session) => SessionDto(
                  orderNumber: session.orderNumber,
                  type: session.type,
                  duration: session.duration,
                  exercises: session.exercises
                      .map(
                        (exercise) => ExerciseDetailsDto(
                          exerciseId: exercise.id,
                          comment: exercise.comment,
                          orderNumber: exercise.orderNumber,
                          approaches: exercise.approaches
                              .map(
                                (approach) => ApproachDto(
                                  orderNumber: approach.orderNumber,
                                  repsCount: approach.repsCount,
                                  weight: approach.weight,
                                  rest: approach.rest,
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        ),
      );

      emit(const CreateWorkoutState.success());
      emit(const CreateWorkoutState.idle());
    } catch (e, s) {
      addError(e, s);

      emit(const CreateWorkoutState.error());
      emit(const CreateWorkoutState.idle());
    }
  }
}
