part of 'create_workout_bloc.dart';

typedef CreateWorkoutStateMatch<T, S extends CreateWorkoutState> = T Function(S state);

sealed class CreateWorkoutState extends Equatable {
  const CreateWorkoutState();

  const factory CreateWorkoutState.idle() = _IdleState;

  const factory CreateWorkoutState.loading() = _LoadingState;

  const factory CreateWorkoutState.success() = _SuccessState;

  const factory CreateWorkoutState.error() = _ErrorState;

  bool get isLoading => maybeMap(
        orElse: () => false,
        loading: (_) => true,
      );

  T map<T>({
    required CreateWorkoutStateMatch<T, _IdleState> idle,
    required CreateWorkoutStateMatch<T, _LoadingState> loading,
    required CreateWorkoutStateMatch<T, _SuccessState> success,
    required CreateWorkoutStateMatch<T, _ErrorState> error,
  }) =>
      switch (this) {
        final _IdleState state => idle(state),
        final _LoadingState state => loading(state),
        final _SuccessState state => success(state),
        final _ErrorState state => error(state),
      };

  T? mapOrNull<T>({
    CreateWorkoutStateMatch<T, _IdleState>? idle,
    CreateWorkoutStateMatch<T, _LoadingState>? loading,
    CreateWorkoutStateMatch<T, _SuccessState>? success,
    CreateWorkoutStateMatch<T, _ErrorState>? error,
  }) =>
      map<T?>(
        idle: idle ?? (_) => null,
        loading: loading ?? (_) => null,
        success: success ?? (_) => null,
        error: error ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    CreateWorkoutStateMatch<T, _IdleState>? idle,
    CreateWorkoutStateMatch<T, _LoadingState>? loading,
    CreateWorkoutStateMatch<T, _SuccessState>? success,
    CreateWorkoutStateMatch<T, _ErrorState>? error,
  }) =>
      map<T>(
        idle: idle ?? (_) => orElse(),
        loading: loading ?? (_) => orElse(),
        success: success ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );
}

/// States

class _IdleState extends CreateWorkoutState {
  const _IdleState();

  @override
  List<Object?> get props => [];
}

class _LoadingState extends CreateWorkoutState {
  const _LoadingState();

  @override
  List<Object?> get props => [];
}

class _SuccessState extends CreateWorkoutState {
  const _SuccessState();

  @override
  List<Object?> get props => [];
}

class _ErrorState extends CreateWorkoutState {
  const _ErrorState();

  @override
  List<Object?> get props => [];
}
