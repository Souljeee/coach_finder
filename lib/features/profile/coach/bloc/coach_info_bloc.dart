import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/features/profile/coach/data/data_sources/dtos/coach_info_dto.dart';
import 'package:coach_finder/features/profile/coach/data/data_sources/dtos/coach_rate_dto.dart';
import 'package:coach_finder/features/profile/coach/data/repositories/coach_repository.dart';
import 'package:equatable/equatable.dart';

part 'coach_info_event.dart';

part 'coach_info_state.dart';

class CoachInfoBloc extends Bloc<CoachInfoEvent, CoachInfoState> {
  final CoachRepository _coachRepository;

  CoachInfoBloc({
    required CoachRepository coachRepository,
  })  : _coachRepository = coachRepository,
        super(const CoachInfoState.loading()) {
    on<CoachInfoEvent>(
      (event, emit) => event.map(
        fetchCoachInfo: (event) => _onFetchCoachInfo(event, emit),
      ),
    );
  }

  Future<void> _onFetchCoachInfo(
    _FetchCoachInfoEvent event,
    Emitter<CoachInfoState> emit,
  ) async {
    try {
      emit(const CoachInfoState.loading());

      final CoachInfoDto coachInfo = await _coachRepository.getCoachInfo(userId: event.userId);

      final List responses = await Future.wait([
        _coachRepository.getCoachRates(coachId: coachInfo.id),
        _coachRepository.getCoachAchievements(coachId: coachInfo.id),
      ]);

      final List<CoachRateDto> rates = responses.first;
      final List<String> achievements = responses.last;

      emit(
        CoachInfoState.success(
          id: coachInfo.id,
          experience: coachInfo.experience,
          description: coachInfo.description,
          rating: coachInfo.rating,
          rates: rates,
          achievements: achievements,
        ),
      );
    } catch (e, s) {
      addError(e, s);

      emit(const CoachInfoState.error());
    }
  }
}
