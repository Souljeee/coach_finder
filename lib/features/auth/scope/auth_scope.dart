import 'package:coach_finder/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract interface class AuthController {
  void signInWithEmailAndPassword(String email, String password);

  void signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  void signOut();

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
  @override
  // TODO: implement authenticated
  bool get authenticated => throw UnimplementedError();

  @override
  void signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
  }

  @override
  void signOut() {
    // TODO: implement signOut
  }

  @override
  void signUpWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmailAndPassword
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return _AuthInherited(
          authController: this,
          authState: state,
          child: widget.child,
        );
      },
    );
  }
}

class _AuthInherited extends InheritedWidget {
  /// Create _AuthInherited widget
  const _AuthInherited({
    required super.child,
    required this.authController,
    required AuthState authState,
  }) : _authState = authState;

  /// Auth controller
  final AuthController authController;

  final AuthState _authState;

  @override
  bool updateShouldNotify(_AuthInherited oldWidget) =>
      _authState != oldWidget._authState;
}
