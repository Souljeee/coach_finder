import 'package:coach_finder/common/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final bool maxSize;
  final VoidCallback onTap;
  final bool isLoading;

  final Color color;

  const CustomElevatedButton({
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.maxSize = false,
    this.color = AppColors.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: Ink(
          height: 56,
          width: maxSize ? double.infinity : null,
          color: color,
          child: InkWell(
            onTap: onTap,
            child: Align(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: isLoading
                    ? const SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
