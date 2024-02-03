import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/common/dependencies/app_dependencies.dart';
import 'package:coach_finder/features/auth/bloc/auth_bloc.dart';
import 'package:coach_finder/features/auth/widget/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract interface class AuthController {
  void signInWithEmailAndPassword(String email,
      String password,
      AccountType accountType,);

  void signOut(String email);

  bool get authenticated;
}

class AuthScope extends StatefulWidget {
  final Widget child;

  const AuthScope({
    required this.child,
    super.key,
  });

  static AuthController of(BuildContext context) {
    final _AuthInherited? result =
    context.dependOnInheritedWidgetOfExactType<_AuthInherited>();

    assert(result != null, 'No AuthScope found in context');

    return result!.authController;
  }

  @override
  State<AuthScope> createState() => _AuthScopeState();
}

class _AuthScopeState extends State<AuthScope> implements AuthController {
  late final AuthBloc _authBloc;
  late AuthState _authState;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _authBloc = AuthBloc(
      authRepository: AppDependenciesScope
          .of(context)
          .authRepository,
    )
      ..add(const AuthEvent.checkAuth());

    _authState = _authBloc.state;

    super.didChangeDependencies();
  }

  @override
  bool get authenticated => _authState.isAuthorized;

  @override
  void signInWithEmailAndPassword(String email,
      String password,
      AccountType accountType,) {
    _authBloc.add(
      AuthEvent.signIn(
        email: email,
        password: password,
        accountType: accountType,
      ),
    );
  }

  @override
  void signOut(String email) {
    _authBloc.add(AuthEvent.signOut(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          _authState = state;

          return _AuthInherited(
            authController: this,
            authState: state,
            child: state.map(
              checkingAuth: (state) => Container(),
              authorized: (_) => widget.child,
              unauthorized: (_) => const AuthScreen(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();

    super.dispose();
  }
}

class _AuthInherited extends InheritedWidget {
  const _AuthInherited({
    required super.child,
    required this.authController,
    required AuthState authState,
  }) : _authState = authState;

  final AuthController authController;

  final AuthState _authState;

  @override
  bool updateShouldNotify(_AuthInherited oldWidget) =>
      _authState != oldWidget._authState;
}
