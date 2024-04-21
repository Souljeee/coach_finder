import 'package:coach_finder/common/theme/colors.dart';
import 'package:flutter/material.dart';

enum ElevatedButtonStyle {
  flat(
    backgroundColor: AppColors.primary,
    textColor: AppColors.white,
  ),
  tonal(
    backgroundColor: AppColors.white,
    textColor: AppColors.secondary,
  ),
  transparent(
    backgroundColor: Colors.transparent,
    textColor: AppColors.secondary,
  );

  final Color backgroundColor;
  final Color textColor;

  const ElevatedButtonStyle({
    required this.backgroundColor,
    required this.textColor,
  });
}

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final bool maxSize;
  final VoidCallback? onTap;
  final bool isLoading;
  final ElevatedButtonStyle style;
  final IconData? icon;

  const CustomElevatedButton({
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.maxSize = false,
    this.style = ElevatedButtonStyle.flat,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: Ink(
          width: maxSize ? double.infinity : null,
          color: onTap != null ? style.backgroundColor : AppColors.lightGray,
          child: InkWell(
            onTap: onTap,
            child: Align(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: isLoading
                    ? SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: style.textColor,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            Icon(
                              icon,
                              color: style.textColor,
                              size: 20,
                            ),
                            const SizedBox(width: 16),
                          ],
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: style.textColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
