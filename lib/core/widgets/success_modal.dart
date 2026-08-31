import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'app_button.dart';

class SuccessModal extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> summaryItems;
  final String primaryButtonText;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;
  final bool isBangla;

  const SuccessModal({
    super.key,
    required this.title,
    required this.description,
    this.summaryItems = const [],
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
    this.isBangla = false,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    List<Widget> summaryItems = const [],
    required String primaryButtonText,
    required VoidCallback onPrimaryPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
    bool isBangla = false,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SuccessModal(
        title: title,
        description: description,
        summaryItems: summaryItems,
        primaryButtonText: primaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        secondaryButtonText: secondaryButtonText,
        onSecondaryPressed: onSecondaryPressed,
        isBangla: isBangla,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated Success Icon with pulsing halo
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success.withValues(alpha: 0.15),
              border: Border.all(color: AppColors.success.withValues(alpha: 0.4), width: 2),
            ),
            child: const Center(
              child: Icon(Icons.check_circle_rounded, size: 44, color: AppColors.success),
            ),
          ),
          const SizedBox(height: 18),

          Text(
            title,
            style: AppTypography.headingLarge(isDark: isDark, isBangla: isBangla),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
            textAlign: TextAlign.center,
          ),

          if (summaryItems.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBg,
                borderRadius: AppRadius.borderMd,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                  width: 1,
                ),
              ),
              child: Column(
                children: summaryItems,
              ),
            ),
          ],

          const SizedBox(height: 28),
          AppButton(
            text: primaryButtonText,
            onPressed: onPrimaryPressed,
            variant: ButtonVariant.primary,
            isBangla: isBangla,
          ),
          if (secondaryButtonText != null && onSecondaryPressed != null) ...[
            const SizedBox(height: 10),
            AppButton(
              text: secondaryButtonText!,
              onPressed: onSecondaryPressed,
              variant: ButtonVariant.ghost,
              isBangla: isBangla,
            ),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
