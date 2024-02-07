import 'package:equatable/equatable.dart';

typedef AuthRepositoryEventsMatch<T, S extends AuthRepositoryEvents> = T Function(S event);

sealed class AuthRepositoryEvents extends Equatable {
  const AuthRepositoryEvents();

  const factory AuthRepositoryEvents.login() = _LoginEvent;
  const factory AuthRepositoryEvents.logout() = _LogoutEvent;

  T map<T>({
    required AuthRepositoryEventsMatch<T, _LoginEvent> login,
    required AuthRepositoryEventsMatch<T, _LogoutEvent> logout,
  }) =>
      switch (this) {
        final _LoginEvent event => login(event),
        final _LogoutEvent event => logout(event),
      };

  T? mapOrNull<T>({
    AuthRepositoryEventsMatch<T, _LoginEvent>? login,
    AuthRepositoryEventsMatch<T, _LogoutEvent>? logout,
  }) =>
      map<T?>(
        login: login ?? (_) => null,
        logout: logout ?? (_) => null,
      );
}

class _LoginEvent extends AuthRepositoryEvents {
  const _LoginEvent();

  @override
  List<Object?> get props => [];
}

class _LogoutEvent extends AuthRepositoryEvents {
  const _LogoutEvent();

  @override
  List<Object?> get props => [];
}
