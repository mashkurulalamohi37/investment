import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/core/constants/project_seeds.dart';

class MilestoneTimelineWidget extends StatelessWidget {
  final List<Milestone>? milestones;
  final bool isBangla;
  final Function(Milestone)? onMilestoneTap;

  const MilestoneTimelineWidget({
    super.key,
    this.milestones,
    required this.isBangla,
    this.onMilestoneTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = milestones ?? ProjectSeeds.landVest100.milestones;

    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        final isLast = index == items.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Icon & Rule
              SizedBox(
                width: 28,
                child: Column(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.isCompleted ? palette.pine : palette.surfaceSunken,
                        border: Border.all(
                          color: item.isCompleted ? palette.pine : palette.ruleStrong,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: item.isCompleted
                            ? Icon(Icons.check, size: 11, color: palette.canvas)
                            : Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: palette.inkTertiary,
                                ),
                              ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1.5,
                          color: item.isCompleted ? palette.pine : palette.rule,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Content Block (0 radius, 1px rule)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: AppRadius.borderZero,
                      border: Border.all(
                        color: item.isCompleted ? palette.pine.withValues(alpha: 0.3) : palette.rule,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                isBangla ? item.titleBn : item.title,
                                style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              CurrencyFormatter.formatDate(item.date, isBangla: isBangla),
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10.5,
                                color: palette.inkSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            color: palette.inkSecondary,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

typedef TimelineWidget = MilestoneTimelineWidget;
