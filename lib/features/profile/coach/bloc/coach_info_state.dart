part of 'coach_info_bloc.dart';

typedef CoachInfoStateMatch<T, S extends CoachInfoState> = T Function(S state);

sealed class CoachInfoState extends Equatable {
  const CoachInfoState();

  const factory CoachInfoState.loading() = _LoadingState;

  const factory CoachInfoState.success({
    required String id,
    required int? experience,
    required String? description,
    required double rating,
    required List<CoachRateDto> rates,
    required List<String> achievements,
  }) = _SuccessState;

  const factory CoachInfoState.error() = _ErrorState;

  T map<T>({
    required CoachInfoStateMatch<T, _LoadingState> loading,
    required CoachInfoStateMatch<T, _SuccessState> success,
    required CoachInfoStateMatch<T, _ErrorState> error,
  }) =>
      switch (this) {
        final _LoadingState state => loading(state),
        final _SuccessState state => success(state),
        final _ErrorState state => error(state),
      };

  T? mapOrNull<T>({
    CoachInfoStateMatch<T, _LoadingState>? loading,
    CoachInfoStateMatch<T, _SuccessState>? success,
    CoachInfoStateMatch<T, _ErrorState>? error,
  }) =>
      map<T?>(
        loading: loading ?? (_) => null,
        success: success ?? (_) => null,
        error: error ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    CoachInfoStateMatch<T, _LoadingState>? loading,
    CoachInfoStateMatch<T, _SuccessState>? success,
    CoachInfoStateMatch<T, _ErrorState>? error,
  }) =>
      map<T>(
        loading: loading ?? (_) => orElse(),
        success: success ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );
}

/// States

class _LoadingState extends CoachInfoState {
  const _LoadingState();

  @override
  List<Object?> get props => [];
}

class _SuccessState extends CoachInfoState {
  final String id;
  final int? experience;
  final String? description;
  final double rating;
  final List<CoachRateDto> rates;
  final List<String> achievements;

  const _SuccessState({
    required this.id,
    required this.experience,
    required this.description,
    required this.rating,
    required this.rates,
    required this.achievements,
  });

  @override
  List<Object?> get props => [
        id,
        experience,
        description,
        rating,
        rates,
        achievements,
      ];
}

class _ErrorState extends CoachInfoState {
  const _ErrorState();

  @override
  List<Object?> get props => [];
}
