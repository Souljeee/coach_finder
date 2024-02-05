import 'package:coach_finder/common/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ValidationMessagesMap = Map<String, String Function(Object)>?;

class CustomTextField<T> extends StatelessWidget {
  final FormControl<T> controller;
  final String hint;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValidationMessagesMap? validationMessages;

  const CustomTextField({
    required this.controller,
    required this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.validationMessages,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControl: controller,
      cursorColor: AppColors.primary,
      validationMessages: validationMessages,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.primary,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
