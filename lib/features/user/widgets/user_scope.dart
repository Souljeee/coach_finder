import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/common/dependencies/app_dependencies.dart';
import 'package:coach_finder/features/profile/data/data_sources/dtos/user_dto.dart';
import 'package:coach_finder/features/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserController {
  AccountType get accountType;

  String? get firstName;

  String? get lastName;

  String get email;

  String get id;

  DateTime get createAccountDate;
}

class UserScope extends StatefulWidget {
  final Widget child;

  const UserScope({
    required this.child,
    super.key,
  });

  static UserController of(BuildContext context) {
    final _UserInh? result = context.dependOnInheritedWidgetOfExactType<_UserInh>();
    assert(result != null, 'No UserScope found in context');
    return result!.controller;
  }

  @override
  State<UserScope> createState() => _UserScopeState();
}

class _UserScopeState extends State<UserScope> implements UserController {
  UserDto? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        userRepository: AppDependenciesScope.of(context).userRepository,
      )..add(const UserEvent.fetchUser()),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.mapOrNull(
            success: (state) {
              setState(() {
                user = state.user;
              });
            },
          );
        },
        builder: (context, state) {
          return state.map(
            loading: (_) => const Scaffold(
              body: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            success: (state) {
              return _UserInh(
                controller: this,
                child: widget.child,
              );
            },
            error: (_) => Scaffold(
              body: SafeArea(
                child: Container(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  AccountType get accountType => user!.accountType;

  @override
  DateTime get createAccountDate => user!.createAccountDate;

  @override
  String get email => user!.email;

  @override
  String? get firstName => user!.firstName;

  @override
  String get id => user!.id;

  @override
  String? get lastName => user!.lastName;
}

class _UserInh extends InheritedWidget {
  final UserController controller;

  const _UserInh({
    required this.controller,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_UserInh old) {
    return controller.id != old.controller.id ||
        controller.accountType != old.controller.accountType ||
        controller.email != old.controller.email ||
        controller.createAccountDate != old.controller.createAccountDate ||
        controller.lastName != old.controller.lastName ||
        controller.firstName != old.controller.firstName;
  }
}
