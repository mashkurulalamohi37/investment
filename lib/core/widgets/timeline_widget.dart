import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/project_model.dart';

class MilestoneTimelineWidget extends StatelessWidget {
  final List<Milestone> milestones;
  final bool isBangla;
  final Function(Milestone)? onMilestoneTap;

  const MilestoneTimelineWidget({
    super.key,
    required this.milestones,
    required this.isBangla,
    this.onMilestoneTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: List.generate(milestones.length, (index) {
        final item = milestones[index];
        final isLast = index == milestones.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Icon & Line
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.isCompleted
                            ? AppColors.success
                            : (isDark ? AppColors.darkSurface : const Color(0xFFE2E8F0)),
                        border: Border.all(
                          color: item.isCompleted
                              ? AppColors.success
                              : (isDark ? AppColors.darkCardBorder : const Color(0xFFCBD5E1)),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: item.isCompleted
                            ? const Icon(Icons.check, size: 14, color: Colors.white)
                            : Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDark ? AppColors.darkTextMuted : const Color(0xFF94A3B8),
                                ),
                              ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: item.isCompleted
                              ? AppColors.success.withValues(alpha: 0.5)
                              : (isDark ? AppColors.darkDivider : const Color(0xFFE2E8F0)),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Content Block
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20.0),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : AppColors.lightCard,
                      borderRadius: AppRadius.borderMd,
                      border: Border.all(
                        color: item.isCompleted
                            ? AppColors.success.withValues(alpha: isDark ? 0.3 : 0.2)
                            : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              CurrencyFormatter.formatDate(item.date, isBangla: isBangla),
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                color: item.isCompleted ? AppColors.successDark : AppColors.lightTextMuted,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (item.isCompleted)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.successLight,
                                  borderRadius: AppRadius.borderXs,
                                ),
                                child: Text(
                                  isBangla ? 'সম্পন্ন' : 'Completed',
                                  style: AppTypography.caption().copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.successDark,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isBangla ? item.titleBn : item.title,
                          style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
                        ),
                        if (item.documentRef != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.attach_file_rounded, size: 13, color: AppColors.accentGoldDark),
                              const SizedBox(width: 4),
                              Text(
                                '${isBangla ? 'সংযুক্ত দলিল:' : 'Attached Deed:'} ${item.documentRef}',
                                style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                  color: isDark ? AppColors.accentGoldLight : AppColors.accentGoldDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
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
