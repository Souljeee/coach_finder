import 'package:coach_finder/common/data/secure_storage.dart';
import 'package:coach_finder/common/network/network.dart';
import 'package:coach_finder/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:coach_finder/features/auth/data/repository/auth_repository.dart';
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
        context.dependOnInheritedWidgetOfExactType<_AppDependenciesInh>();

    assert(result != null, 'No AppDependenciesScope found in context');

    return result!.appDependencies;
  }

  @override
  State<AppDependenciesScope> createState() => _AppDependenciesScopeState();
}

class _AppDependenciesScopeState extends State<AppDependenciesScope> {
  final _secureStorage = SecureStorage();
  late final _networkClient =
      CustomNetworkClient(secureStorage: _secureStorage).client;

  late final RemoteAuthDataSource _remoteAuthDataSource = RemoteAuthDataSource(
    networkClient: _networkClient,
  );

  late final AuthRepository _authRepository = AuthRepository(
    authRemoteDataSource: _remoteAuthDataSource,
    secureStorage: _secureStorage,
  );

  late final _appDependencies = AppDependencies(
    secureStorage: _secureStorage,
    networkClient: _networkClient,
    authRepository: _authRepository,
    remoteAuthDataSource: _remoteAuthDataSource,
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

  const AppDependencies({
    required this.secureStorage,
    required this.networkClient,
    required this.remoteAuthDataSource,
    required this.authRepository,
  });

  @override
  List<Object?> get props => [
        secureStorage,
        networkClient,
        remoteAuthDataSource,
        authRepository,
      ];
}
