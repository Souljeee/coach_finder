import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeScope extends StatefulWidget {
  final Widget child;

  const ThemeScope({
    required this.child,
    super.key,
  });

  @override
  State<ThemeScope> createState() => _ThemeScopeState();
}

class _ThemeScopeState extends State<ThemeScope> {
  final _appTheme = AppTheme(
    colors: AppColors(),
  );

  @override
  Widget build(BuildContext context) {
    return _ThemeInh(
      appTheme: _appTheme,
      child: widget.child,
    );
  }
}

class _ThemeInh extends InheritedWidget {
  final AppTheme appTheme;

  const _ThemeInh({
    required this.appTheme,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_ThemeInh old) {
    return appTheme != old.appTheme;
  }
}

class AppTheme extends Equatable {
  final AppColors colors;

  const AppTheme({required this.colors});

  @override
  List<Object?> get props => [colors];
}

class AppColors {
  static const primary = Color(0xFF90BEDE);
  static const secondary = Color(0xFF68EDC6);
  static const background = Color(0xFFDFFDFF);
  static const accent = Color(0xFF90F3FF);
  static const soft = Color(0xFFE5E1EE);
  static const text = Color(0xFF000000);
  static const textSecondary = Color(0xFF676666);
}
