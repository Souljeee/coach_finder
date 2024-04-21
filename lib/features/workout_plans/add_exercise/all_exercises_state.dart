part of 'all_exercises_bloc.dart';

typedef AllExercisesStateMatch<T, S extends AllExercisesState> = T Function(S state);

sealed class AllExercisesState extends Equatable {
  const AllExercisesState();

  const factory AllExercisesState.loading() = _LoadingState;

  const factory AllExercisesState.success({
    required List<ExerciseDto> exercises,
  }) = _SuccessState;

  const factory AllExercisesState.error() = _ErrorState;

  T map<T>({
    required AllExercisesStateMatch<T, _LoadingState> loading,
    required AllExercisesStateMatch<T, _SuccessState> success,
    required AllExercisesStateMatch<T, _ErrorState> error,
  }) =>
      switch (this) {
        final _LoadingState state => loading(state),
        final _SuccessState state => success(state),
        final _ErrorState state => error(state),
      };

  T? mapOrNull<T>({
    AllExercisesStateMatch<T, _LoadingState>? loading,
    AllExercisesStateMatch<T, _SuccessState>? success,
    AllExercisesStateMatch<T, _ErrorState>? error,
  }) =>
      map<T?>(
        loading: loading ?? (_) => null,
        success: success ?? (_) => null,
        error: error ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    AllExercisesStateMatch<T, _LoadingState>? loading,
    AllExercisesStateMatch<T, _SuccessState>? success,
    AllExercisesStateMatch<T, _ErrorState>? error,
  }) =>
      map<T>(
        loading: loading ?? (_) => orElse(),
        success: success ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );
}

/// States

class _LoadingState extends AllExercisesState {
  const _LoadingState();

  @override
  List<Object?> get props => [];
}

class _SuccessState extends AllExercisesState {
  final List<ExerciseDto> exercises;

  const _SuccessState({required this.exercises});

  @override
  List<Object?> get props => [exercises];
}

class _ErrorState extends AllExercisesState {
  const _ErrorState();

  @override
  List<Object?> get props => [];
}
