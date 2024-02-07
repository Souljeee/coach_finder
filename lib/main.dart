import 'package:coach_finder/common/dependencies/app_dependencies.dart';
import 'package:coach_finder/common/router/app_routing.dart';
import 'package:coach_finder/features/auth/widget/auth_scope.dart';
import 'package:coach_finder/features/guards/widgets/guards.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final FocusScopeNode _focusNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: _focusNode,
      child: GestureDetector(
        onTap: () => _focusNode.unfocus(),
        child: MaterialApp.router(
          theme: ThemeData(fontFamily: 'RobotoMono'),
          routerConfig: router,
          builder: (context, child) {
            return AppDependenciesScope(
              child: AuthScope(
                child: Guards(
                  child: Scaffold(
                    body: SafeArea(
                      child: child!,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
