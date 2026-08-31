import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'app_button.dart';

class ErrorStateView extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;
  final bool isBangla;

  const ErrorStateView({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.isBangla = false,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: palette.vermilion.withValues(alpha: 0.10),
              ),
              child: Icon(Icons.error_outline_rounded, size: 36, color: palette.vermilion),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 160,
              child: AppButton(
                label: isBangla ? 'আবার চেষ্টা করুন' : 'Retry',
                onPressed: onRetry,
                variant: AppButtonVariant.primary,
                isBangla: isBangla,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
