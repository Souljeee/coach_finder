import 'package:coach_finder/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FormControl<String> emailController = FormControl();
  final FormControl<String> passwordController = FormControl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: CustomTextField<String>(
                  controller: emailController,
                  hint: 'Эл. почта',
                  prefixIcon: const Icon(Icons.alternate_email),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: CustomTextField<String>(
                  controller: passwordController,
                  hint: 'Пароль',
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
