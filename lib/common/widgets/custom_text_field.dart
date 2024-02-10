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
  final bool obscureText;
  final Color? suffixIconColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;

  const CustomTextField({
    required this.controller,
    required this.hint,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIcon,
    this.validationMessages,
    this.obscureText = false,
    this.enabledBorderColor = AppColors.secondary,
    this.focusedBorderColor = AppColors.secondary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      obscureText: obscureText,
      formControl: controller,
      cursorColor: AppColors.primary,
      validationMessages: validationMessages,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.primary,
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.text),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: enabledBorderColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor,
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
