part of 'auth_bloc.dart';

typedef AuthStateMatch<T, S extends AuthState> = T Function(S state);

sealed class AuthState extends Equatable {
  const AuthState();

  const factory AuthState.processing() = _ProcessingState;

  const factory AuthState.authorized() = _AuthorizedState;

  const factory AuthState.unauthorized({String? message}) = _UnauthorizedState;

  bool get isAuthorized => maybeMap(
        orElse: () => false,
        authorized: (_) => true,
      );

  bool get isProcessing => maybeMap(
    orElse: () => false,
    processing: (_) => true,
  );

  T map<T>({
    required AuthStateMatch<T, _ProcessingState> processing,
    required AuthStateMatch<T, _AuthorizedState> authorized,
    required AuthStateMatch<T, _UnauthorizedState> unauthorized,
  }) =>
      switch (this) {
        final _ProcessingState state => processing(state),
        final _AuthorizedState state => authorized(state),
        final _UnauthorizedState state => unauthorized(state),
      };

  T? mapOrNull<T>({
    AuthStateMatch<T, _ProcessingState>? processing,
    AuthStateMatch<T, _AuthorizedState>? authorized,
    AuthStateMatch<T, _UnauthorizedState>? unauthorized,
  }) =>
      map<T?>(
        processing: processing ?? (_) => null,
        authorized: authorized ?? (_) => null,
        unauthorized: unauthorized ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    AuthStateMatch<T, _ProcessingState>? processing,
    AuthStateMatch<T, _AuthorizedState>? authorized,
    AuthStateMatch<T, _UnauthorizedState>? unauthorized,
  }) =>
      map<T>(
        processing: processing ?? (_) => orElse(),
        authorized: authorized ?? (_) => orElse(),
        unauthorized: unauthorized ?? (_) => orElse(),
      );
}

/// States

class _AuthorizedState extends AuthState {
  const _AuthorizedState();

  @override
  List<Object?> get props => [];
}

class _UnauthorizedState extends AuthState {
  final String? message;
  const _UnauthorizedState({this.message = null});

  @override
  List<Object?> get props => [message];
}

class _ProcessingState extends AuthState {
  const _ProcessingState();

  @override
  List<Object?> get props => [];
}
