part of 'create_workout_bloc.dart';

typedef CreateWorkoutEventMatch<T, S extends CreateWorkoutEvent> = T Function(S event);

sealed class CreateWorkoutEvent extends Equatable {
  const CreateWorkoutEvent();

  const factory CreateWorkoutEvent.createWorkoutPlan({
    required String title,
    required String? description,
    required Difficulty difficulty,
    required String type,
    required int sessionsPerWeek,
    required int planDuration,
    required List<SessionModel> sessions,
  }) = _CreateWorkoutPlanEvent;

  T map<T>({
    required CreateWorkoutEventMatch<T, _CreateWorkoutPlanEvent> createWorkoutPlan,
  }) =>
      switch (this) {
        final _CreateWorkoutPlanEvent event => createWorkoutPlan(event),
      };
}

class _CreateWorkoutPlanEvent extends CreateWorkoutEvent {
  final String title;
  final String? description;
  final Difficulty difficulty;
  final String type;
  final int sessionsPerWeek;
  final int planDuration;
  final List<SessionModel> sessions;

  const _CreateWorkoutPlanEvent({
    required this.title,
    required this.description,
    required this.difficulty,
    required this.type,
    required this.sessionsPerWeek,
    required this.planDuration,
    required this.sessions,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        difficulty,
        type,
        sessionsPerWeek,
        planDuration,
        sessions,
      ];
}
