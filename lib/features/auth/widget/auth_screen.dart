import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/common/theme/colors.dart';
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
    return const Scaffold(
      body: SafeArea(
        child: AccountTypeScope(
          child: Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _AccountTypeSelector(),
              ),
              const Text('solo'),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountTypeSelector extends StatefulWidget {
  const _AccountTypeSelector({
    super.key,
  });

  @override
  State<_AccountTypeSelector> createState() => _AccountTypeSelectorState();
}

class _AccountTypeSelectorState extends State<_AccountTypeSelector> {
  final FormControl<String> emailController = FormControl();
  final FormControl<String> passwordController = FormControl();

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
            color: AppColors.soft,
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
              ),
              const SizedBox(height: 8),
              CustomTextField<String>(
                controller: passwordController,
                hint: 'Пароль',
                prefixIcon: const Icon(Icons.lock),
              ),
            ],
          ),
        ),
      ],
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
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.soft : AppColors.textSecondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
