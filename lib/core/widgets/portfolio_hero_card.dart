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
        color: isDark ? const Color(0xFF0E1A16) : const Color(0xFF0B281E),
        borderRadius: AppRadius.borderLg,
        boxShadow: isDark ? AppShadows.darkHero : AppShadows.lightHero,
        border: Border.all(
          color: isDark ? const Color(0xFF1E3A30) : const Color(0xFF1A4637),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Institutional Escrow & Custody Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.successLight,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isBangla ? 'সিটি ব্যাংক এসক্রো হিসাব • ল্যান্ডভেস্ট ১০০' : 'CITY BANK ESCROW • LANDVEST 100',
                    style: AppTypography.caption().copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: AppRadius.borderXs,
                ),
                child: Text(
                  isBangla ? 'দলিল নং ৪৯৮২/২৬' : 'DEED #4982/26',
                  style: AppTypography.caption().copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Main Capital Balance
          Text(
            isBangla ? 'মোট বিনিয়োগকৃত মূলধন' : 'Total Portfolio Valuation',
            style: AppTypography.caption().copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedCountText(
            endValue: totalInvested,
            isBangla: isBangla,
            style: AppTypography.financialAmountLarge().copyWith(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 16),

          // Secondary Financial Columns
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'মালিকানাধীন শেয়ার লট' : 'Allocated Lots',
                      style: AppTypography.caption().copyWith(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isBangla
                          ? '${CurrencyFormatter.toBanglaDigits(totalShares.toString())} টি শেয়ার (লট ৪১-৪৪)'
                          : '$totalShares Shares (Lots 041-044)',
                      style: AppTypography.headingSmall().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 28, color: Colors.white12),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'বিতরণকৃত মুনাফা' : 'Realized Dividend',
                      style: AppTypography.caption().copyWith(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      CurrencyFormatter.format(realizedProfit, isBangla: isBangla),
                      style: AppTypography.headingSmall().copyWith(
                        color: AppColors.successLight,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
