part of 'all_exercises_bloc.dart';

typedef AllExercisesEventMatch<T, S extends AllExercisesEvent> = T Function(S event);

sealed class AllExercisesEvent extends Equatable {
  const AllExercisesEvent();

  const factory AllExercisesEvent.fetchAllExercises() = _FetchAllExercisesEvent;
  const factory AllExercisesEvent.searchExercises({required String? query}) = _SearchExercisesEvent;

  T map<T>({
    required AllExercisesEventMatch<T, _FetchAllExercisesEvent> fetchAllExercises,
    required AllExercisesEventMatch<T, _SearchExercisesEvent> searchExercises,
  }) =>
      switch (this) {
        final _FetchAllExercisesEvent event => fetchAllExercises(event),
        final _SearchExercisesEvent event => searchExercises(event),
      };
}

class _FetchAllExercisesEvent extends AllExercisesEvent {
  const _FetchAllExercisesEvent();

  @override
  List<Object?> get props => [];
}

class _SearchExercisesEvent extends AllExercisesEvent {
  final String? query;
  const _SearchExercisesEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
