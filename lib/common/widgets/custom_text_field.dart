import 'package:coach_finder/common/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField<T> extends StatelessWidget {
  final FormControl<T> controller;
  final String hint;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextField({
    required this.controller,
    required this.hint,
    this.suffixIcon,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControl: controller,
      cursorColor: AppColors.primary,
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
      ),
    );
  }
}
