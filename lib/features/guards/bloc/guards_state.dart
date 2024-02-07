part of 'guards_bloc.dart';

typedef GuardsStateMatch<T, S extends GuardsState> = T Function(S state);

sealed class GuardsState extends Equatable {
  const GuardsState();

  const factory GuardsState.loading() = _LoadingState;

  const factory GuardsState.success({
    required bool isAuthenticated,
  }) = _SuccessState;

  const factory GuardsState.error() = _ErrorState;

  T map<T>({
    required GuardsStateMatch<T, _LoadingState> loading,
    required GuardsStateMatch<T, _SuccessState> success,
    required GuardsStateMatch<T, _ErrorState> error,
  }) =>
      switch (this) {
        final _LoadingState state => loading(state),
        final _SuccessState state => success(state),
        final _ErrorState state => error(state),
      };

  T? mapOrNull<T>({
    GuardsStateMatch<T, _LoadingState>? loading,
    GuardsStateMatch<T, _SuccessState>? success,
    GuardsStateMatch<T, _ErrorState>? error,
  }) =>
      map<T?>(
        loading: loading ?? (_) => null,
        success: success ?? (_) => null,
        error: error ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    GuardsStateMatch<T, _LoadingState>? loading,
    GuardsStateMatch<T, _SuccessState>? success,
    GuardsStateMatch<T, _ErrorState>? error,
  }) =>
      map<T>(
        loading: loading ?? (_) => orElse(),
        success: success ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );
}

/// States

class _LoadingState extends GuardsState {
  const _LoadingState();

  @override
  List<Object?> get props => [];
}

class _SuccessState extends GuardsState {
  final bool isAuthenticated;

  const _SuccessState({required this.isAuthenticated});

  @override
  List<Object?> get props => [isAuthenticated];
}

class _ErrorState extends GuardsState {
  const _ErrorState();

  @override
  List<Object?> get props => [];
}
