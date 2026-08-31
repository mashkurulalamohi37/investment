import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/theme/app_shadows.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/animated_count_text.dart';

class PortfolioHeroCard extends StatelessWidget {
  final double totalInvested;
  final int totalShares;
  final double realizedProfit;
  final bool isBangla;
  final VoidCallback? onExploreTap;
  final VoidCallback? onTransparencyTap;

  const PortfolioHeroCard({
    super.key,
    required this.totalInvested,
    required this.totalShares,
    required this.realizedProfit,
    this.isBangla = false,
    this.onExploreTap,
    this.onTransparencyTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.heroGradientDark : AppColors.heroGradientLight,
        borderRadius: AppRadius.borderXl,
        boxShadow: isDark ? AppShadows.darkHero : AppShadows.lightHero,
        border: Border.all(
          color: AppColors.accentGold.withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      child: Stack(
        children: [
          // Subtle background decorative glowing sphere
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentGold.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success.withValues(alpha: 0.06),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top header label & Verified Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: AppRadius.borderSm,
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 16,
                            color: AppColors.accentGoldLight,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isBangla ? 'মোট সক্রিয় পোর্টফোলিও' : 'TOTAL ACTIVE PORTFOLIO',
                          style: AppTypography.caption().copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.2),
                        borderRadius: AppRadius.borderFull,
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.4),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isBangla ? 'স্বচ্ছ ও যাচাইকৃত' : 'Audited & Active',
                            style: AppTypography.caption().copyWith(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Large Main Balance with Animated Count Odometer
                AnimatedCountText(
                  endValue: totalInvested,
                  isBangla: isBangla,
                  style: AppTypography.financialAmountLarge().copyWith(
                    color: Colors.white,
                    fontSize: 36,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isBangla
                      ? 'ল্যান্ডভেস্ট ১০০ প্রকল্পে সাবস্ক্রিপশনকৃত মূলধন'
                      : 'Principal invested in LandVest 100 Opportunity',
                  style: AppTypography.bodySmall().copyWith(
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(color: Colors.white12, thickness: 1),
                const SizedBox(height: 16),

                // Secondary Metrics Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'মোট শেয়ার লট' : 'Allocated Shares',
                            style: AppTypography.caption().copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            isBangla
                                ? '${CurrencyFormatter.toBanglaDigits(totalShares.toString())} টি শেয়ার'
                                : '$totalShares Shares',
                            style: AppTypography.headingSmall().copyWith(
                              color: AppColors.accentGoldLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 32, color: Colors.white12),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'উত্তোলিত মোট লভ্যাংশ' : 'Realized Return',
                            style: AppTypography.caption().copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            CurrencyFormatter.format(realizedProfit, isBangla: isBangla),
                            style: AppTypography.headingSmall().copyWith(
                              color: AppColors.successLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
