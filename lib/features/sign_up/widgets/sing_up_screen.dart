import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController =
      FormControl<String>(validators: [Validators.required]);
  final _passwordController =
      FormControl<String>(validators: [Validators.required]);
  final _passwordRepeatController =
      FormControl<String>(validators: [Validators.required]);

  late final FormGroup _signUpFormGroup = FormGroup({
    'email': _emailController,
    'password': _passwordController,
    'password_repeat': _passwordRepeatController,
  });

  bool hidePassword = true;
  bool hideRepeatPassword = true;

  bool showError = false;

  AccountType _selectedType = AccountType.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Регистрация',
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ReactiveForm(
        formGroup: _signUpFormGroup,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _emailController,
                  hint: 'Эл.почта',
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'Введите адрес электронной почты'
                  },
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  obscureText: hidePassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    child: const Icon(Icons.remove_red_eye),
                  ),
                  controller: _passwordController,
                  hint: 'Пароль',
                  validationMessages: {
                    ValidationMessage.required: (_) => 'Введите пароль'
                  },
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  obscureText: hideRepeatPassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        hideRepeatPassword = !hideRepeatPassword;
                      });
                    },
                    child: const Icon(Icons.remove_red_eye),
                  ),
                  controller: _passwordRepeatController,
                  hint: 'Повторите пароль',
                  validationMessages: {
                    ValidationMessage.required: (_) => 'Повторите пароль'
                  },
                ),
                const SizedBox(height: 16),
                _AnimatedAccountTypeSelectToggle(
                  onTypeChanged: (type){
                    setState(() {
                      _selectedType = type;
                    });
                  },
                ),
                if (showError) ...[
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Пароли должны совпадать',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return CustomElevatedButton(
                      title: 'Зарегистрироваться',
                      onTap: form.valid ? _onSignUpTap : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUpTap() {
    setState(() {
      showError = false;
    });

    if (_passwordRepeatController.value != _passwordController.value) {
      setState(() {
        showError = true;
      });

      return;
    }
  }
}

class _AnimatedAccountTypeSelectToggle extends StatefulWidget {
  final void Function(AccountType type) onTypeChanged;
  const _AnimatedAccountTypeSelectToggle({
    required this.onTypeChanged,
  });

  @override
  State<_AnimatedAccountTypeSelectToggle> createState() =>
      _AnimatedAccountTypeSelectToggleState();
}

class _AnimatedAccountTypeSelectToggleState
    extends State<_AnimatedAccountTypeSelectToggle> {
  AccountType _selectedType = AccountType.client;

  late final double width = MediaQuery.of(context).size.width - 32;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      _selectedType = AccountType.client;
                      widget.onTypeChanged(_selectedType);
                      setState(() {});
                    },
                    child: const ColoredBox(
                      color: AppColors.lightGray,
                      child: Center(
                        child: Text(
                          'Спортсмен',
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      _selectedType = AccountType.coach;
                      widget.onTypeChanged(_selectedType);
                      setState(() {});
                    },
                    child: const ColoredBox(
                      color: AppColors.lightGray,
                      child: Center(
                        child: Text(
                          'Тренер',
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              alignment: _selectedType == AccountType.client
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: width / 2,
                decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    _selectedType == AccountType.client
                        ? 'Спортсмен'
                        : 'Тренер',
                    style: const TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
