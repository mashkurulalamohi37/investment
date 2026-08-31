import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/lot_map_widget.dart';
import 'package:swapnojatri/data/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isBangla;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.isBangla = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = (project.allocatedShares / project.totalShares).clamp(0.0, 1.0);

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderCard,
      child: Container(
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: AppRadius.borderCard,
          border: Border.all(color: palette.rule, width: 1.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 96px-tall miniature lot map thumbnail
            SizedBox(
              height: 96,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: LotMapWidget(
                      allocatedShares: project.allocatedShares,
                      userLots: const ['LOT-041', 'LOT-042', 'LOT-043', 'LOT-044'],
                      isBangla: isBangla,
                      isInteractive: false,
                      isCompact: true,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: AppRadius.borderChip,
                        border: Border.all(color: palette.rule, width: 1.0),
                      ),
                      child: Text(
                        isBangla ? 'প্লট ৪১৮ • সাভার' : 'Plot 418 • Savar',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: palette.inkSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Location
                  Text(
                    isBangla ? project.titleBn : project.title,
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isBangla
                        ? '${project.locationBn} • দলিল নং ৪৯৮২/২৬'
                        : '${project.location} • Deed #4982/26',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                      color: palette.inkSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Ruled 2-Column Stat Table
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: palette.surfaceSunken,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: palette.rule, width: 1.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBangla ? 'প্রতি অংশ মূল্য' : 'Price per share',
                                style: AppTypography.micro(isDark: isDark, isBangla: isBangla),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                CurrencyFormatter.format(project.pricePerShare, isBangla: isBangla),
                                style: AppTypography.amountSmall(isDark: isDark, isBangla: isBangla).copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 24, color: palette.rule),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBangla ? 'উপলব্ধ অংশ' : 'Shares available',
                                style: AppTypography.micro(isDark: isDark, isBangla: isBangla),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                isBangla
                                    ? '${CurrencyFormatter.toBanglaDigits((project.totalShares - project.allocatedShares).toString())} টি'
                                    : '${project.totalShares - project.allocatedShares} of ${project.totalShares}',
                                style: AppTypography.amountSmall(isDark: isDark, isBangla: isBangla).copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: palette.pine,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Funding Progress Bar (4px track in surfaceSunken, fill in pine)
                  ClipRRect(
                    borderRadius: AppRadius.borderFull,
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      backgroundColor: palette.surfaceSunken,
                      valueColor: AlwaysStoppedAnimation<Color>(palette.pine),
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isBangla
                            ? '${CurrencyFormatter.toBanglaDigits(project.allocatedShares.toString())}/১০০ অংশ বরাদ্দ সম্পন্ন'
                            : '${project.allocatedShares} of 100 shares allocated',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          fontSize: 11.5,
                          color: palette.inkSecondary,
                        ),
                      ),
                      Text(
                        isBangla
                            ? 'লক্ষ্য: ${CurrencyFormatter.format(project.targetFund, isBangla: true, compact: true)}'
                            : 'Target: ${CurrencyFormatter.format(project.targetFund, compact: true)}',
                        style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
