import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';

class InvestmentStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;
  final bool isBangla;

  const InvestmentStepper({
    super.key,
    required this.currentStep,
    required this.steps,
    required this.isBangla,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: List.generate(steps.length, (index) {
          final isCompleted = index < currentStep;
          final isCurrent = index == currentStep;

          Color nodeColor;
          Color textColor;

          if (isCompleted) {
            nodeColor = AppColors.success;
            textColor = Colors.white;
          } else if (isCurrent) {
            nodeColor = isDark ? AppColors.accentGold : AppColors.primary;
            textColor = isDark ? AppColors.primaryDark : Colors.white;
          } else {
            nodeColor = isDark ? AppColors.darkDivider : const Color(0xFFE2E8F0);
            textColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
          }

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: nodeColor,
                          border: isCurrent
                              ? Border.all(
                                  color: (isDark ? AppColors.accentGoldLight : AppColors.primaryLight).withValues(alpha: 0.5),
                                  width: 3,
                                )
                              : null,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(Icons.check, size: 14, color: Colors.white)
                              : Text(
                                  '${index + 1}',
                                  style: AppTypography.caption().copyWith(
                                    color: textColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        steps[index],
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          fontSize: 10,
                          fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w400,
                          color: isCurrent
                              ? (isDark ? AppColors.accentGoldLight : AppColors.primary)
                              : (isCompleted ? AppColors.successDark : AppColors.lightTextMuted),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                if (index < steps.length - 1)
                  Container(
                    width: 16,
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    color: isCompleted
                        ? AppColors.success
                        : (isDark ? AppColors.darkDivider : const Color(0xFFE2E8F0)),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
