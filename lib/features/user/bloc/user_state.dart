part of 'user_bloc.dart';

typedef UserStateMatch<T, S extends UserState> = T Function(S state);

sealed class UserState extends Equatable {
  const UserState();

  const factory UserState.loading() = _LoadingState;

  const factory UserState.success({
    required UserDto user,
  }) = _SuccessState;

  const factory UserState.error() = _ErrorState;

  T map<T>({
    required UserStateMatch<T, _LoadingState> loading,
    required UserStateMatch<T, _SuccessState> success,
    required UserStateMatch<T, _ErrorState> error,
  }) =>
      switch (this) {
        final _LoadingState state => loading(state),
        final _SuccessState state => success(state),
        final _ErrorState state => error(state),
      };

  T? mapOrNull<T>({
    UserStateMatch<T, _LoadingState>? loading,
    UserStateMatch<T, _SuccessState>? success,
    UserStateMatch<T, _ErrorState>? error,
  }) =>
      map<T?>(
        loading: loading ?? (_) => null,
        success: success ?? (_) => null,
        error: error ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    UserStateMatch<T, _LoadingState>? loading,
    UserStateMatch<T, _SuccessState>? success,
    UserStateMatch<T, _ErrorState>? error,
  }) =>
      map<T>(
        loading: loading ?? (_) => orElse(),
        success: success ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );
}

/// States

class _LoadingState extends UserState {
  const _LoadingState();

  @override
  List<Object?> get props => [];
}

class _SuccessState extends UserState {
  final UserDto user;

  const _SuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class _ErrorState extends UserState {
  const _ErrorState();

  @override
  List<Object?> get props => [];
}
