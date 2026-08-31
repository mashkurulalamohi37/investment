import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';

class SuccessModal extends StatelessWidget {
  final String title;
  final String description;
  final String primaryButtonText;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;
  final List<Widget> summaryItems;
  final bool isBangla;

  const SuccessModal({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
    this.summaryItems = const [],
    this.isBangla = false,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String description,
    required String primaryButtonText,
    required VoidCallback onPrimaryPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
    List<Widget> summaryItems = const [],
    bool isBangla = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SuccessModal(
        title: title,
        description: description,
        primaryButtonText: primaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        summaryItems: summaryItems,
        secondaryButtonText: secondaryButtonText,
        onSecondaryPressed: onSecondaryPressed,
        isBangla: isBangla,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderSheet,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated Success Icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: palette.pineTint,
              border: Border.all(color: palette.pine.withValues(alpha: 0.3), width: 2),
            ),
            child: Center(
              child: Icon(Icons.check_circle_rounded, size: 44, color: palette.pine),
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
                color: palette.surfaceSunken,
                borderRadius: AppRadius.borderCard,
                border: Border.all(
                  color: palette.rule,
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
            label: primaryButtonText,
            onPressed: onPrimaryPressed,
            variant: AppButtonVariant.primary,
            isBangla: isBangla,
          ),
          if (secondaryButtonText != null) ...[
            const SizedBox(height: 10),
            AppButton(
              label: secondaryButtonText!,
              onPressed: onSecondaryPressed,
              variant: AppButtonVariant.quiet,
              isBangla: isBangla,
            ),
          ],
        ],
      ),
    );
  }
}
