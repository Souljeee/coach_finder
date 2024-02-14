import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/features/auth/data/repository/auth_repository.dart';
import 'package:coach_finder/features/auth/data/repository/events.dart';
import 'package:coach_finder/features/sign_up/data/repository/sign_up_repository.dart';
import 'package:equatable/equatable.dart';

part 'guards_event.dart';

part 'guards_state.dart';

class GuardsBloc extends Bloc<GuardsEvent, GuardsState> {
  final AuthRepository _authRepository;
  late StreamSubscription<AuthRepositoryEvents> _authRepositorySubscription;

  GuardsBloc({
    required AuthRepository authRepository,
    required SignUpRepository signUpRepository,
  })  : _authRepository = authRepository,
        super(const GuardsState.loading()) {
    on<GuardsEvent>(
      (event, emit) => event.map(
        guardsCheckingRequested: (_) => _onGuardsCheckingRequested(emit),
        authStatusChanged: (event) => _onAuthStatusChangedEvent(event, emit),
      ),
    );

    _authRepositorySubscription = _authRepository.eventStream.listen(_listenAuthRepository);
  }

  @override
  Future<void> close() async {
    await _authRepositorySubscription.cancel();


    return super.close();
  }

  void _listenAuthRepository(AuthRepositoryEvents events) {
    events.map(
      login: (_) => add(const GuardsEvent.authStatusChanged(hasAuth: true)),
      logout: (_) => add(const GuardsEvent.authStatusChanged(hasAuth: false)),
    );
  }

  void _onAuthStatusChangedEvent(
    _AuthStatusChangedEvent event,
    Emitter<GuardsState> emit,
  ) {
    emit(GuardsState.success(isAuthenticated: event.hasAuth));
  }

  Future<void> _onGuardsCheckingRequested(Emitter<GuardsState> emit) async {
    try {
      final hasAccess = await _authRepository.checkAuth();

      emit(GuardsState.success(isAuthenticated: hasAccess));
    } catch (e, s) {
      addError(e, s);

      emit(const GuardsState.error());
    }
  }
}
