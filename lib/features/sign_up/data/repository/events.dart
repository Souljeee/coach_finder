import 'package:equatable/equatable.dart';

typedef SignUpEventMatch<T, S extends SignUpRepositoryEvents> = T Function(S event);

sealed class SignUpRepositoryEvents extends Equatable {
  const SignUpRepositoryEvents();

  const factory SignUpRepositoryEvents.signUpCompleted() = _SignUpCompletedEvent;

  T map<T>({
    required SignUpEventMatch<T, SignUpRepositoryEvents> signUpCompleted,
  }) =>
      switch (this) {
        final _SignUpCompletedEvent event => signUpCompleted(event),
      };
}

class _SignUpCompletedEvent extends SignUpRepositoryEvents {
  const _SignUpCompletedEvent();

  @override
  List<Object?> get props => [];
}
