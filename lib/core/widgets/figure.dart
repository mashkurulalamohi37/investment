import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';

class Figure extends StatelessWidget {
  final String label;
  final String value;
  final String? contextLine;
  final Color? accentColor;
  final bool isBangla;
  final bool hasLeftBorder;
  final VoidCallback? onTap;

  const Figure({
    super.key,
    required this.label,
    required this.value,
    this.contextLine,
    this.accentColor,
    this.isBangla = false,
    this.hasLeftBorder = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final content = Container(
      padding: hasLeftBorder ? const EdgeInsets.only(left: 12.0) : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: hasLeftBorder
            ? Border(
                left: BorderSide(
                  color: accentColor ?? palette.rule,
                  width: 2.0,
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla).copyWith(
              color: palette.inkSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppTypography.amountLarge(isDark: isDark, isBangla: isBangla).copyWith(
              color: accentColor ?? palette.ink,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          if (contextLine != null) ...[
            const SizedBox(height: 2),
            Text(
              contextLine!,
              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                color: palette.inkTertiary,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderControl,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: AppRadius.borderCard,
            border: Border.all(color: palette.rule, width: 1.0),
          ),
          child: content,
        ),
      );
    }

    return content;
  }
}

// Backward compatibility alias for KpiCard
class KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? accentColor;
  final bool isBangla;
  final VoidCallback? onTap;

  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.accentColor,
    this.isBangla = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderCard,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: AppRadius.borderCard,
          border: Border.all(color: palette.rule, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                color: palette.inkSecondary,
                fontSize: 11.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTypography.amountMedium(isDark: isDark, isBangla: isBangla).copyWith(
                color: accentColor ?? palette.ink,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
