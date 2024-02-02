part of 'auth_bloc.dart';

typedef AuthEventMatch<T, S extends AuthEvent> = T Function(S event);

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  const factory AuthEvent.signIn({
    required String email,
    required String password,
    required AccountType accountType,
  }) = _SignInEvent;

  const factory AuthEvent.signOut({required String email}) = _SignOutEvent;

  const factory AuthEvent.checkAuth() = _CheckAuthEvent;

  T map<T>({
    required AuthEventMatch<T, _SignInEvent> signIn,
    required AuthEventMatch<T, _SignOutEvent> signOut,
    required AuthEventMatch<T, _CheckAuthEvent> checkAuth,
  }) =>
      switch (this) {
        final _SignInEvent event => signIn(event),
        final _SignOutEvent event => signOut(event),
        final _CheckAuthEvent event => checkAuth(event),
      };
}

class _SignInEvent extends AuthEvent {
  final String email;
  final String password;
  final AccountType accountType;

  const _SignInEvent({
    required this.email,
    required this.password,
    required this.accountType,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        accountType,
      ];
}

class _SignOutEvent extends AuthEvent {
  final String email;

  const _SignOutEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class _CheckAuthEvent extends AuthEvent {
  const _CheckAuthEvent();

  @override
  List<Object?> get props => [];
}

