part of 'sign_up_bloc.dart';

typedef SignUpStateMatch<T, S extends SignUpState> = T Function(S state);

sealed class SignUpState extends Equatable {
  const SignUpState();

  const factory SignUpState.idle() = _IdleState;

  const factory SignUpState.codeCreating() = _CodeCreatingState;

  const factory SignUpState.codeCreated({required String email}) = _CodeCreatedState;

  const factory SignUpState.codeCreatingError(
      {required CodeCreatingErrorType errorType}) = _CodeCreatingErrorState;

  const factory SignUpState.codeConfirming() = _CodeConfirmingState;

  const factory SignUpState.codeConfirmed() = _CodeConfirmedState;

  const factory SignUpState.error() = _ErrorState;

  bool get isCodeCreating => maybeMap(
        orElse: () => false,
        codeCreating: (_) => true,
      );

  T map<T>({
    required SignUpStateMatch<T, _IdleState> idle,
    required SignUpStateMatch<T, _CodeCreatingState> codeCreating,
    required SignUpStateMatch<T, _CodeCreatedState> codeCreated,
    required SignUpStateMatch<T, _CodeCreatingErrorState> codeCreatingError,
    required SignUpStateMatch<T, _CodeConfirmingState> codeConfirming,
    required SignUpStateMatch<T, _CodeConfirmedState> codeConfirmed,
    required SignUpStateMatch<T, _ErrorState> error,
  }) =>
      switch (this) {
        final _IdleState state => idle(state),
        final _CodeCreatingState state => codeCreating(state),
        final _CodeCreatedState state => codeCreated(state),
        final _CodeCreatingErrorState state => codeCreatingError(state),
        final _CodeConfirmingState state => codeConfirming(state),
        final _CodeConfirmedState state => codeConfirmed(state),
        final _ErrorState state => error(state),
      };

  T? mapOrNull<T>({
    SignUpStateMatch<T, _IdleState>? idle,
    SignUpStateMatch<T, _CodeCreatingState>? codeCreating,
    SignUpStateMatch<T, _CodeCreatedState>? codeCreated,
    SignUpStateMatch<T, _CodeCreatingErrorState>? codeCreatingError,
    SignUpStateMatch<T, _CodeConfirmingState>? codeConfirming,
    SignUpStateMatch<T, _CodeConfirmedState>? codeConfirmed,
    SignUpStateMatch<T, _ErrorState>? error,
  }) =>
      map<T?>(
        idle: idle ?? (_) => null,
        codeCreating: codeCreating ?? (_) => null,
        codeCreated: codeCreated ?? (_) => null,
        codeCreatingError: codeCreatingError ?? (_) => null,
        codeConfirming: codeConfirming ?? (_) => null,
        codeConfirmed: codeConfirmed ?? (_) => null,
        error: error ?? (_) => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    SignUpStateMatch<T, _IdleState>? idle,
    SignUpStateMatch<T, _CodeCreatingState>? codeCreating,
    SignUpStateMatch<T, _CodeCreatedState>? codeCreated,
    SignUpStateMatch<T, _CodeCreatingErrorState>? codeCreatingError,
    SignUpStateMatch<T, _CodeConfirmingState>? codeConfirming,
    SignUpStateMatch<T, _CodeConfirmedState>? codeConfirmed,
    SignUpStateMatch<T, _ErrorState>? error,
  }) =>
      map<T>(
        idle: idle ?? (_) => orElse(),
        codeCreating: codeCreating ?? (_) => orElse(),
        codeCreated: codeCreated ?? (_) => orElse(),
        codeCreatingError: codeCreatingError ?? (_) => orElse(),
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

class _CodeCreatingState extends SignUpState {
  const _CodeCreatingState();

  @override
  List<Object?> get props => [];
}

class _CodeCreatedState extends SignUpState {
  final String email;

  const _CodeCreatedState({required this.email});

  @override
  List<Object?> get props => [email];
}

class _CodeCreatingErrorState extends SignUpState {
  final CodeCreatingErrorType errorType;

  const _CodeCreatingErrorState({required this.errorType});

  @override
  List<Object?> get props => [errorType];
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
