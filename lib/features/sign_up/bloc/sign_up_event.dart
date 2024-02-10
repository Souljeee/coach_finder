part of 'sign_up_bloc.dart';

typedef SignUpEventMatch<T, S extends SignUpEvent> = T Function(S event);

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  const factory SignUpEvent.createCodeRequested({
    required String email,
    required String password,
    required AccountType accountType,
  }) = _CreateCodeRequestedEvent;

  const factory SignUpEvent.codeConfirmRequested({required String code}) =
      _CodeConfirmRequestedEvent;

  T map<T>({
    required SignUpEventMatch<T, _CreateCodeRequestedEvent> createCodeRequested,
    required SignUpEventMatch<T, _CodeConfirmRequestedEvent> codeConfirmRequested,
  }) =>
      switch (this) {
        final _CreateCodeRequestedEvent event => createCodeRequested(event),
        final _CodeConfirmRequestedEvent event => codeConfirmRequested(event),
      };
}

class _CreateCodeRequestedEvent extends SignUpEvent {
  final String email;
  final String password;
  final AccountType accountType;

  const _CreateCodeRequestedEvent({
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

class _CodeConfirmRequestedEvent extends SignUpEvent {
  final String code;

  const _CodeConfirmRequestedEvent({required this.code});

  @override
  List<Object?> get props => [code];
}
