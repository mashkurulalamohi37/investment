import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/theme/app_shadows.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'status_chip.dart';
import 'package:swapnojatri/data/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isBangla;
  final VoidCallback onTap;
  final bool isCompact;

  const ProjectCard({
    super.key,
    required this.project,
    required this.isBangla,
    required this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = project.fundingProgress;
    final percent = (progress * 100).toInt();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderXl,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: AppRadius.borderXl,
            border: Border.all(
              color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
              width: 1,
            ),
            boxShadow: isDark ? AppShadows.darkCard : AppShadows.lightCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Banner & Image with Badges
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
                    child: SizedBox(
                      height: isCompact ? 140 : 175,
                      width: double.infinity,
                      child: Image.network(
                        project.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: isDark ? AppColors.darkSurface : AppColors.primarySubtle,
                          child: Center(
                            child: Icon(
                              Icons.terrain_rounded,
                              size: 48,
                              color: isDark ? AppColors.accentGold : AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Dark Vignette overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.4),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Top Row badges
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: AppRadius.borderFull,
                        border: Border.all(color: Colors.white24, width: 0.8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on_outlined, size: 12, color: AppColors.accentGoldLight),
                          const SizedBox(width: 4),
                          Text(
                            project.location,
                            style: AppTypography.caption().copyWith(color: Colors.white, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: StatusChip.project(project.status, isBangla: isBangla),
                  ),
                  // Bottom Code label
                  Positioned(
                    bottom: 12,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withValues(alpha: 0.85),
                        borderRadius: AppRadius.borderXs,
                        border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.5), width: 0.8),
                      ),
                      child: Text(
                        project.code,
                        style: AppTypography.caption().copyWith(
                          color: AppColors.accentGoldLight,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Content Area
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? project.nameBn : project.name,
                      style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isBangla ? project.descriptionBn : project.description,
                      style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 16),

                    // Progress Bar & Percentage
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isBangla ? 'তহবিল সংগ্রহ অগ্রগতি' : 'Funding Progress',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                        ),
                        Text(
                          isBangla
                              ? '${CurrencyFormatter.toBanglaDigits(percent.toString())}% (${CurrencyFormatter.toBanglaDigits(project.allocatedShares.toString())}/${CurrencyFormatter.toBanglaDigits(project.totalShares.toString())} শেয়ার)'
                              : '$percent% (${project.allocatedShares}/${project.totalShares} Shares)',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: AppRadius.borderFull,
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 7,
                        backgroundColor: isDark ? AppColors.darkDivider : const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 14),

                    // Financial Parameters Strip
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isBangla ? 'প্রতি শেয়ার' : 'Per Share',
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              CurrencyFormatter.format(project.pricePerShare, isBangla: isBangla),
                              style: AppTypography.financialAmountSmall(isDark: isDark),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              isBangla ? 'অবশিষ্ট শেয়ার' : 'Available',
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.accentGold.withValues(alpha: isDark ? 0.2 : 0.15),
                                borderRadius: AppRadius.borderSm,
                              ),
                              child: Text(
                                isBangla
                                    ? '${CurrencyFormatter.toBanglaDigits(project.availableShares.toString())} টি শেয়ার'
                                    : '${project.availableShares} Shares left',
                                style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                  color: isDark ? AppColors.accentGoldLight : AppColors.accentGoldDark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
