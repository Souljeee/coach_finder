import 'package:coach_finder/common/dependencies/app_dependencies.dart';
import 'package:coach_finder/common/router/app_routing.dart';
import 'package:coach_finder/common/theme/theme_scope.dart';
import 'package:coach_finder/features/auth/widget/auth_scope.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      builder: (context, child) {
        return ThemeScope(
          child: AppDependenciesScope(
            child: AuthScope(
              child: Scaffold(
                body: SafeArea(
                  child: child!,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
