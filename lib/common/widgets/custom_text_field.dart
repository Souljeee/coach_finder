import 'package:coach_finder/common/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ValidationMessagesMap = Map<String, String Function(Object)>?;

class CustomTextField<T> extends StatelessWidget {
  final FormControl<T> controller;
  final void Function(FormControl<T>)? onChanged;
  final String hint;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValidationMessagesMap? validationMessages;
  final bool obscureText;
  final Color? suffixIconColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final int? maxLines;
  final String? helperText;
  final Color cursorColor;

  const CustomTextField({
    required this.controller,
    required this.hint,
    this.onChanged,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIcon,
    this.validationMessages,
    this.obscureText = false,
    this.enabledBorderColor = AppColors.secondary,
    this.focusedBorderColor = AppColors.secondary,
    this.cursorColor = AppColors.primary,
    this.maxLines,
    this.helperText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      obscureText: obscureText,
      formControl: controller,
      cursorColor: cursorColor,
      onChanged: onChanged,
      validationMessages: validationMessages,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        helperText: helperText,
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
