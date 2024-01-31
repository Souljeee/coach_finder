part of 'auth_bloc.dart';

typedef AuthStateMatch<T, S extends AuthState> = T Function(S state);

sealed class AuthState extends Equatable {
  const AuthState();

  const factory AuthState.checkingAuth() = _CheckingAuthState;

  const factory AuthState.authorized() = _AuthorizedState;

  const factory AuthState.unauthorized() = _UnauthorizedState;

  bool get isAuthorized => maybeMap(
        orElse: () => false,
        authorized: (_) => true,
      );

  T map<T>({
    required AuthStateMatch<T, _CheckingAuthState> checkingAuth,
    required AuthStateMatch<T, _AuthorizedState> authorized,
    required AuthStateMatch<T, _UnauthorizedState> unauthorized,
  }) =>
      switch (this) {
        final _CheckingAuthState state => checkingAuth(state),
        final _AuthorizedState state => authorized(state),
        final _UnauthorizedState state => unauthorized(state),
      };

  T? mapOrNull<T>({
    AuthStateMatch<T, _CheckingAuthState>? checkingAuth,
    AuthStateMatch<T, _AuthorizedState>? authorized,
    AuthStateMatch<T, _UnauthorizedState>? unauthorized,
  }) =>
      map<T?>(
        checkingAuth: checkingAuth ?? (_) => null,
        authorized: authorized ?? (_) => null,
        unauthorized: unauthorized ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    AuthStateMatch<T, _CheckingAuthState>? checkingAuth,
    AuthStateMatch<T, _AuthorizedState>? authorized,
    AuthStateMatch<T, _UnauthorizedState>? unauthorized,
  }) =>
      map<T>(
        checkingAuth: checkingAuth ?? (_) => orElse(),
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
  const _UnauthorizedState();

  @override
  List<Object?> get props => [];
}

class _CheckingAuthState extends AuthState {
  const _CheckingAuthState();

  @override
  List<Object?> get props => [];
}
