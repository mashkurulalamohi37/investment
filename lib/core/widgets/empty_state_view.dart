import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool isBangla;

  const EmptyStateView({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.buttonText,
    this.onButtonPressed,
    this.isBangla = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final palette = context.palette;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A hairline-ringed well, not a filled tinted circle (§2: no big
            // icon in a tinted circle) and no gold as a dark-mode accent swap
            // — gold stays reserved for seals only.
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: palette.surfaceSunken,
                border: Border.all(color: palette.rule, width: 1.0),
              ),
              child: Icon(
                icon,
                size: 30,
                color: palette.inkTertiary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: 200,
                child: AppButton(
                  label: buttonText!,
                  onPressed: onButtonPressed,
                  variant: AppButtonVariant.primary,
                  isBangla: isBangla,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
