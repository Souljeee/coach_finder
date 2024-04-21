part of 'all_exercises_bloc.dart';

typedef AllExercisesEventMatch<T, S extends AllExercisesEvent> = T Function(S event);

sealed class AllExercisesEvent extends Equatable {
  const AllExercisesEvent();

  const factory AllExercisesEvent.fetchAllExercises() = _FetchAllExercisesEvent;

  T map<T>({
    required AllExercisesEventMatch<T, _FetchAllExercisesEvent> fetchAllExercises,
  }) =>
      switch (this) {
        final _FetchAllExercisesEvent event => fetchAllExercises(event),
      };
}

class _FetchAllExercisesEvent extends AllExercisesEvent {
  const _FetchAllExercisesEvent();

  @override
  List<Object?> get props => [];
}
