import 'package:coach_finder/app_routing.dart';
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
        return Scaffold(
          body: SafeArea(
            child: child!,
          ),
        );
      }
    );
  }
}
