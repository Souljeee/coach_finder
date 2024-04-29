part of 'user_bloc.dart';

typedef UserEventMatch<T, S extends UserEvent> = T Function(S event);

sealed class UserEvent extends Equatable {
  const UserEvent();

  const factory UserEvent.fetchUser() = _FetchUserEvent;

  T map<T>({
    required UserEventMatch<T, _FetchUserEvent> fetchUser,
  }) =>
      switch (this) {
        final _FetchUserEvent event => fetchUser(event),
      };
}

class _FetchUserEvent extends UserEvent {
  const _FetchUserEvent();

  @override
  List<Object?> get props => [];
}
