import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/features/profile/data/data_sources/dtos/user_dto.dart';
import 'package:coach_finder/features/profile/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserState.loading()) {
    on<UserEvent>(
      (event, emit) => event.map(
        fetchUser: (event) => _onFetchUser(event, emit),
      ),
    );
  }

  Future<void> _onFetchUser(
    _FetchUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(const UserState.loading());

      final UserDto user = await _userRepository.getUser();

      emit(UserState.success(user: user));
    } catch (e, s) {
      addError(e, s);

      emit(const UserState.error());
    }
  }
}
