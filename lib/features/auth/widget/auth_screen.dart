import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/common/widgets/custom_text_field.dart';
import 'package:coach_finder/features/auth/widget/account_type_scope.dart';
import 'package:coach_finder/features/auth/widget/auth_scope.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: AccountTypeScope(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Center(
                child: Image.asset(
                  'assets/app_logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 42),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _AccountTypeSelector(),
              ),
              const SizedBox(height: 16),
              const _CreateAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/sign_up'),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          'Создать аккаунт',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 16,
            decoration: TextDecoration.underline,
            color: AppColors.primary,
            decorationColor: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _AccountTypeSelector extends StatefulWidget {
  const _AccountTypeSelector();

  @override
  State<_AccountTypeSelector> createState() => _AccountTypeSelectorState();
}

class _AccountTypeSelectorState extends State<_AccountTypeSelector> {
  final FormControl<String> emailController = FormControl(
    validators: [Validators.required],
  );
  final FormControl<String> passwordController =
      FormControl(validators: [Validators.required]);

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _TypeSelectionButton(
                title: 'Спортсмен',
                isSelected: AccountTypeScope.of(context).isClient,
                onSelect: () {
                  AccountTypeScope.of(context)
                      .setAccountType(AccountType.client);
                },
              ),
            ),
            Expanded(
              child: _TypeSelectionButton(
                title: 'Тренер',
                isSelected: AccountTypeScope.of(context).isCoach,
                onSelect: () {
                  AccountTypeScope.of(context)
                      .setAccountType(AccountType.coach);
                },
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              CustomTextField<String>(
                controller: emailController,
                hint: 'Эл. почта',
                prefixIcon: const Icon(Icons.alternate_email),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      'Введите адрес электронной почты'
                },
              ),
              const SizedBox(height: 8),
              CustomTextField<String>(
                controller: passwordController,
                obscureText: hidePassword,
                hint: 'Пароль',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  child: const Icon(Icons.remove_red_eye),
                ),
                suffixIconColor: AppColors.textSecondary,
                validationMessages: {
                  ValidationMessage.required: (_) => 'Введите пароль'
                },
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              CustomElevatedButton(
                title: 'Войти',
                maxSize: true,
                isLoading: AuthScope.of(context).isProcessing,
                onTap: () => _authUser(context: context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _authUser({required BuildContext context}) {
    if (emailController.value == null) {
      emailController.markAsTouched();

      return;
    }

    if (passwordController.value == null) {
      passwordController.markAsTouched();

      return;
    }

    AuthScope.of(context).signInWithEmailAndPassword(
      emailController.value!,
      passwordController.value!,
      AccountTypeScope.of(context).accountType,
    );
  }
}

class _TypeSelectionButton extends StatelessWidget {
  final String title;
  final bool isSelected;

  final VoidCallback onSelect;

  const _TypeSelectionButton({
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : AppColors.lightGray,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
