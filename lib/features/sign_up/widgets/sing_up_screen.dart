import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/common/dependencies/app_dependencies.dart';
import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/common/widgets/custom_text_field.dart';
import 'package:coach_finder/features/sign_up/bloc/models/errors_type_enums.dart';
import 'package:coach_finder/features/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:collection/collection.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _pageController = PageController(initialPage: 1);

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
      body: BlocProvider(
        create: (context) => SignUpBloc(
          signUpRepository: AppDependenciesScope.of(context).signUpRepository,
        ),
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            state.mapOrNull(
              codeCreatingError: (state) {
                if (state.errorType == CodeCreatingErrorType.UNDEFINED) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Произошла неизвестная ошибка'),
                    ),
                  );
                }
              },
              codeCreated: (_) {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            );
          },
          child: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                _InfoInputSlide(),
                _CodeInputSlide(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoInputSlide extends StatefulWidget {
  const _InfoInputSlide();

  @override
  State<_InfoInputSlide> createState() => _InfoInputSlideState();
}

class _InfoInputSlideState extends State<_InfoInputSlide> {
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

  String? errorText;

  AccountType _selectedType = AccountType.client;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        state.mapOrNull(
          codeCreatingError: (state) {
            if (state.errorType == CodeCreatingErrorType.USER_EXIST) {
              setState(() {
                errorText = 'Пользователь с такой эл. почтой уже существует';
              });
            }
          },
        );
      },
      child: ReactiveForm(
        formGroup: _signUpFormGroup,
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
                onTypeChanged: (type) {
                  setState(() {
                    _selectedType = type;
                  });
                },
              ),
              if (errorText != null) ...[
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    errorText!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return CustomElevatedButton(
                        title: 'Зарегистрироваться',
                        onTap: form.valid
                            ? () => _onSignUpTap(context: context)
                            : null,
                        isLoading: state.isCodeCreating,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUpTap({required BuildContext context}) {
    setState(() {
      errorText = null;
    });

    if (_passwordRepeatController.value != _passwordController.value) {
      setState(() {
        errorText = 'Пароли должны совпадать';
      });

      return;
    }

    BlocProvider.of<SignUpBloc>(context).add(
      SignUpEvent.createCodeRequested(
        email: _emailController.value!,
        password: _passwordController.value!,
        accountType: _selectedType,
      ),
    );
  }
}

class _CodeInputSlide extends StatefulWidget {
  const _CodeInputSlide({
    super.key,
  });

  @override
  State<_CodeInputSlide> createState() => _CodeInputSlideState();
}

class _CodeInputSlideState extends State<_CodeInputSlide> {
  String? email;

  @override
  void initState() {
    super.initState();

    email = BlocProvider.of<SignUpBloc>(context).state.mapOrNull(
          codeCreated: (state) => state.email,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Отправили код подтверждения на $email'),
          const SizedBox(height: 32),
          _CodeInput(),
        ],
      ),
    );
  }
}

class _CodeInput extends StatefulWidget {
  const _CodeInput({
    super.key,
  });

  @override
  State<_CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<_CodeInput> {
  final _firstDigitController = FormControl<String>();
  final _secondDigitController = FormControl<String>();
  final _thirdDigitController = FormControl<String>();
  final _fourthDigitController = FormControl<String>();
  final _fifthDigitController = FormControl<String>();
  final _sixthDigitController = FormControl<String>();

  late final List<FormControl<String>> controllers = [
    _firstDigitController,
    _secondDigitController,
    _thirdDigitController,
    _fourthDigitController,
    _fifthDigitController,
    _sixthDigitController,
  ];

  late final _codeInputFormGroup = FormGroup({
    'first_digit': _firstDigitController,
    'second_digit': _secondDigitController,
    'third_digit': _thirdDigitController,
    'fourth_digit': _fourthDigitController,
    'fifth_digit': _fifthDigitController,
    'sixth_digit': _sixthDigitController,
  });

  @override
  void initState() {
    super.initState();

    _sixthDigitController.valueChanges.listen(
      (value) {
        if(value != null){
          BlocProvider.of<SignUpBloc>(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _codeInputFormGroup,
      child: Row(
        children: controllers
            .mapIndexed(
              (index, controller) => Expanded(
                child: _DigitInputField(
                  index: index,
                  controller: controller,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _DigitInputField extends StatelessWidget {
  final int index;
  final FormControl<String> controller;

  const _DigitInputField({
    required this.index,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ReactiveTextField(
        onChanged: (controller) {
          if (controller.value != null &&
              controller.value!.isNotEmpty &&
              index != 5) {
            FocusScope.of(context).nextFocus();

            return;
          }

          FocusScope.of(context).unfocus();
        },
        formControl: controller,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
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
                    onTap: () {
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
                    onTap: () {
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
