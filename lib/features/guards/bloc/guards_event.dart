part of 'guards_bloc.dart';

typedef GuardsEventMatch<T, S extends GuardsEvent> = T Function(S event);

sealed class GuardsEvent extends Equatable {
  const GuardsEvent();

  const factory GuardsEvent.guardsCheckingRequested() = _GuardsCheckingRequestedEvent;
  const factory GuardsEvent.authStatusChanged({required bool hasAuth}) = _AuthStatusChangedEvent;

  T map<T>({
    required GuardsEventMatch<T, _GuardsCheckingRequestedEvent> guardsCheckingRequested,
    required GuardsEventMatch<T, _AuthStatusChangedEvent> authStatusChanged,
  }) =>
      switch (this) {
        final _GuardsCheckingRequestedEvent event => guardsCheckingRequested(event),
        final _AuthStatusChangedEvent event => authStatusChanged(event),
      };
}

class _GuardsCheckingRequestedEvent extends GuardsEvent {
  const _GuardsCheckingRequestedEvent();

  @override
  List<Object?> get props => [];
}

class _AuthStatusChangedEvent extends GuardsEvent {
  final bool hasAuth;
  const _AuthStatusChangedEvent({required this.hasAuth});

  @override
  List<Object?> get props => [hasAuth];
}
