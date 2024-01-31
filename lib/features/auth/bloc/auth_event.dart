part of 'auth_bloc.dart';

typedef AuthEventMatch<T, S extends AuthEvent> = T Function(S event);

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  const factory AuthEvent.signIn({
    required String email,
    required String password,
  }) = _SignInEvent;

  const factory AuthEvent.signOut() = _SignOutEvent;

  T map<T>({
    required AuthEventMatch<T, _SignInEvent> signIn,
    required AuthEventMatch<T, _SignOutEvent> signOut,
  }) =>
      switch (this) {
        final _SignInEvent event => signIn(event),
        final _SignOutEvent event => signOut(event),
      };
}

class _SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const _SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class _SignOutEvent extends AuthEvent {

  const _SignOutEvent();

  @override
  List<Object?> get props => [];
}
