import 'package:coach_finder/common/data/secure_storage.dart';
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

  late final _appDependencies = AppDependencies(
    secureStorage: _secureStorage,
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

  const AppDependencies({
    required this.secureStorage,
  });

  @override
  List<Object?> get props => [secureStorage];
}
