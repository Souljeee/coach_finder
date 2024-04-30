import 'package:coach_finder/common/data/secure_storage.dart';
import 'package:coach_finder/common/network/network.dart';
import 'package:coach_finder/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:coach_finder/features/auth/data/repository/auth_repository.dart';
import 'package:coach_finder/features/profile/coach/data/data_sources/coach_remote_data_source.dart';
import 'package:coach_finder/features/profile/coach/data/repositories/coach_repository.dart';
import 'package:coach_finder/features/profile/data/data_sources/user_remote_data_source.dart';
import 'package:coach_finder/features/profile/data/repositories/user_repository.dart';
import 'package:coach_finder/features/sign_up/data/data_sources/sign_up_data_source.dart';
import 'package:coach_finder/features/sign_up/data/repository/sign_up_repository.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/workout_plan_remote_data_source.dart';
import 'package:coach_finder/features/workout_plans/common/data/repositories/workout_plan_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppDependenciesScope extends StatefulWidget {
  final Widget child;

  const AppDependenciesScope({
    required this.child,
    super.key,
  });

  static AppDependencies of(BuildContext context) {
    final _AppDependenciesInh? result =
        context.getInheritedWidgetOfExactType<_AppDependenciesInh>();

    assert(result != null, 'No AppDependenciesScope found in context');

    return result!.appDependencies;
  }

  @override
  State<AppDependenciesScope> createState() => _AppDependenciesScopeState();
}

class _AppDependenciesScopeState extends State<AppDependenciesScope> {
  final _secureStorage = SecureStorage();
  late final _networkClient = CustomNetworkClient(secureStorage: _secureStorage).client;

  late final RemoteAuthDataSource _remoteAuthDataSource = RemoteAuthDataSource(
    networkClient: _networkClient,
  );

  late final AuthRepository _authRepository = AuthRepository(
    authRemoteDataSource: _remoteAuthDataSource,
    secureStorage: _secureStorage,
  );

  late final SignUpDataSource _signUpDataSource = SignUpDataSource(
    networkClient: _networkClient,
  );

  late final SignUpRepository _signUpRepository = SignUpRepository(
    signUpDataSource: _signUpDataSource,
  );

  late final WorkoutPlanRemoteDataSource _workoutPlanRemoteDataSource = WorkoutPlanRemoteDataSource(
    networkClient: _networkClient,
  );

  late final WorkoutPlanRepository _workoutPlanRepository = WorkoutPlanRepository(
    workoutPlanRemoteDataSource: _workoutPlanRemoteDataSource,
  );

  late final UserRemoteDataSource _userRemoteDataSource = UserRemoteDataSource(
    networkClient: _networkClient,
  );

  late final UserRepository _userRepository = UserRepository(
    userRemoteDataSource: _userRemoteDataSource,
  );

  late final CoachRemoteDataSource _coachRemoteDataSource = CoachRemoteDataSource(
    networkClient: _networkClient,
  );

  late final CoachRepository _coachRepository = CoachRepository(
    coachRemoteDataSource: _coachRemoteDataSource,
  );

  late final _appDependencies = AppDependencies(
    secureStorage: _secureStorage,
    networkClient: _networkClient,
    authRepository: _authRepository,
    remoteAuthDataSource: _remoteAuthDataSource,
    signUpDataSource: _signUpDataSource,
    signUpRepository: _signUpRepository,
    workoutPlanRemoteDataSource: _workoutPlanRemoteDataSource,
    workoutPlanRepository: _workoutPlanRepository,
    userRemoteDataSource: _userRemoteDataSource,
    userRepository: _userRepository,
    coachRemoteDataSource: _coachRemoteDataSource,
    coachRepository: _coachRepository,
  );

  @override
  Widget build(BuildContext context) {
    return _AppDependenciesInh(
      appDependencies: _appDependencies,
      child: widget.child,
    );
  }
}

class _AppDependenciesInh extends InheritedWidget {
  final AppDependencies appDependencies;

  const _AppDependenciesInh({
    required this.appDependencies,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_AppDependenciesInh old) {
    return appDependencies != old.appDependencies;
  }
}

class AppDependencies extends Equatable {
  final SecureStorage secureStorage;
  final Dio networkClient;

  final RemoteAuthDataSource remoteAuthDataSource;
  final AuthRepository authRepository;

  final SignUpDataSource signUpDataSource;

  final SignUpRepository signUpRepository;

  final WorkoutPlanRemoteDataSource workoutPlanRemoteDataSource;

  final WorkoutPlanRepository workoutPlanRepository;

  final UserRemoteDataSource userRemoteDataSource;

  final UserRepository userRepository;

  final CoachRemoteDataSource coachRemoteDataSource;

  final CoachRepository coachRepository;

  const AppDependencies({
    required this.secureStorage,
    required this.networkClient,
    required this.remoteAuthDataSource,
    required this.authRepository,
    required this.signUpDataSource,
    required this.signUpRepository,
    required this.workoutPlanRemoteDataSource,
    required this.workoutPlanRepository,
    required this.userRemoteDataSource,
    required this.userRepository,
    required this.coachRemoteDataSource,
    required this.coachRepository,
  });

  @override
  List<Object?> get props => [
        secureStorage,
        networkClient,
        remoteAuthDataSource,
        authRepository,
        signUpDataSource,
        signUpRepository,
        workoutPlanRemoteDataSource,
        workoutPlanRepository,
        userRemoteDataSource,
        userRepository,
        coachRemoteDataSource,
        coachRepository,
      ];
}
