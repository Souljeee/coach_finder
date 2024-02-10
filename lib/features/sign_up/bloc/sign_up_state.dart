part of 'sign_up_bloc.dart';

typedef SignUpStateMatch<T, S extends SignUpState> = T Function(S state);

sealed class SignUpState extends Equatable {
  const SignUpState();

  const factory SignUpState.idle() = _IdleState;
  const factory SignUpState.processing() = _ProcessingState;
  const factory SignUpState.codeCreated() = _CodeCreatedState;
  const factory SignUpState.codeConfirming() = _CodeConfirmingState;
  const factory SignUpState.codeConfirmed() = _CodeConfirmedState;
  const factory SignUpState.error() = _ErrorState;

  T map<T>({
    required SignUpStateMatch<T, _IdleState> idle,
    required SignUpStateMatch<T, _ProcessingState> processing,
    required SignUpStateMatch<T, _CodeCreatedState> codeCreated,
    required SignUpStateMatch<T, _CodeConfirmingState> codeConfirming,
    required SignUpStateMatch<T, _CodeConfirmedState> codeConfirmed,
    required SignUpStateMatch<T, _ErrorState> error,
  }) =>
      switch (this) {
        final _IdleState state => idle(state),
        final _ProcessingState state => processing(state),
        final _CodeCreatedState state => codeCreated(state),
        final _CodeConfirmingState state => codeConfirming(state),
        final _CodeConfirmedState state => codeConfirmed(state),
        final _ErrorState state => error(state),
      };

  T? mapOrNull<T>({
    SignUpStateMatch<T, _IdleState>? idle,
    SignUpStateMatch<T, _ProcessingState>? processing,
    SignUpStateMatch<T, _CodeCreatedState>? codeCreated,
    SignUpStateMatch<T, _CodeConfirmingState>? codeConfirming,
    SignUpStateMatch<T, _CodeConfirmedState>? codeConfirmed,
    SignUpStateMatch<T, _ErrorState>? error,
  }) =>
      map<T?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        codeCreated: codeCreated ?? (_) => null,
        codeConfirming: codeConfirming ?? (_) => null,
        codeConfirmed: codeConfirmed ?? (_) => null,
        error: error ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    SignUpStateMatch<T, _IdleState>? idle,
    SignUpStateMatch<T, _ProcessingState>? processing,
    SignUpStateMatch<T, _CodeCreatedState>? codeCreated,
    SignUpStateMatch<T, _CodeConfirmingState>? codeConfirming,
    SignUpStateMatch<T, _CodeConfirmedState>? codeConfirmed,
    SignUpStateMatch<T, _ErrorState>? error,
  }) =>
      map<T>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        codeCreated: codeCreated ?? (_) => orElse(),
        codeConfirming: codeConfirming ?? (_) => orElse(),
        codeConfirmed: codeConfirmed ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );
}

/// States

class _IdleState extends SignUpState {
  const _IdleState();

  @override
  List<Object?> get props => [];
}

class _ProcessingState extends SignUpState {
  const _ProcessingState();

  @override
  List<Object?> get props => [];
}

class _CodeCreatedState extends SignUpState {
  const _CodeCreatedState();

  @override
  List<Object?> get props => [];
}

class _CodeConfirmingState extends SignUpState {
  const _CodeConfirmingState();

  @override
  List<Object?> get props => [];
}

class _CodeConfirmedState extends SignUpState {
  const _CodeConfirmedState();

  @override
  List<Object?> get props => [];
}

class _ErrorState extends SignUpState {
  const _ErrorState();

  @override
  List<Object?> get props => [];
}
