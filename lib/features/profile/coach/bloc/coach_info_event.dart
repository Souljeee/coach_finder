part of 'coach_info_bloc.dart';

typedef CoachInfoEventMatch<T, S extends CoachInfoEvent> = T Function(S event);

sealed class CoachInfoEvent extends Equatable {
  const CoachInfoEvent();

  const factory CoachInfoEvent.fetchCoachInfo({required String userId}) = _FetchCoachInfoEvent;

  T map<T>({
    required CoachInfoEventMatch<T, _FetchCoachInfoEvent> fetchCoachInfo,
  }) =>
      switch (this) {
        final _FetchCoachInfoEvent event => fetchCoachInfo(event),
      };
}

class _FetchCoachInfoEvent extends CoachInfoEvent {
  final String userId;

  const _FetchCoachInfoEvent({required this.userId});

  @override
  List<Object?> get props => [];
}
