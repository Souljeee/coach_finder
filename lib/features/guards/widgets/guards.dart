import 'package:coach_finder/common/dependencies/app_dependencies.dart';
import 'package:coach_finder/features/auth/widget/auth_screen.dart';
import 'package:coach_finder/features/guards/bloc/guards_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Guards extends StatelessWidget {
  final Widget child;

  const Guards({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GuardsBloc(
        authRepository: AppDependenciesScope.of(context).authRepository,
      )..add(const GuardsEvent.guardsCheckingRequested()),
      child: BlocBuilder<GuardsBloc, GuardsState>(
        builder: (context, state) {
          return state.maybeMap(
            success: (state) {
              return AuthGuard(
                isAuthenticated: state.isAuthenticated,
                child: child,
              );
            },
            orElse: () => Container(), // TODO: добавить splash
          );
        },
      ),
    );
  }
}

class AuthGuard extends StatelessWidget {
  final bool isAuthenticated;
  final Widget child;

  const AuthGuard({
    required this.isAuthenticated,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isAuthenticated) {
      return child;
    }

    return Navigator(
      pages: const [
        MaterialPage(
          child: AuthScreen(),
        ),
      ],
      onPopPage: (_, __) => true,
    );
  }
}
