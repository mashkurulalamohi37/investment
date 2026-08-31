import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/amount_text.dart';

class HoldingCard extends StatelessWidget {
  final double totalInvested;
  final int totalShares;
  final double realizedProfit;
  final bool isBangla;
  final VoidCallback? onExploreTap;
  final VoidCallback? onTransparencyTap;

  const HoldingCard({
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
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // The one permitted vertical 6% gradient in the entire application (§4)
        gradient: isDark ? AppColors.holdingCardGradientDark : AppColors.holdingCardGradientLight,
        borderRadius: AppRadius.borderHero,
        border: Border.all(
          color: isDark ? const Color(0xFF1E3A30) : const Color(0xFF1B4838),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top 1.5px Brass Matra Rule
          Container(
            width: 32,
            height: 1.5,
            color: palette.brass,
          ),
          const SizedBox(height: 12),

          // 2. Section Label
          Text(
            isBangla ? 'আপনার মোট বিনিয়োগ' : 'Your total holding',
            style: AppTypography.caption(isBangla: isBangla).copyWith(
              color: palette.canvas.withValues(alpha: 0.70),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),

          // 3. Amount in AmountHero (Rolls once per session)
          AmountText(
            amount: totalInvested,
            isBangla: isBangla,
            animate: true,
            style: AppTypography.amountHero(isBangla: isBangla, color: palette.canvas).copyWith(
              fontSize: 34,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),

          // 4. Hairline Rule at 14% Opacity
          Divider(
            color: palette.canvas.withValues(alpha: 0.14),
            height: 1.0,
          ),
          const SizedBox(height: 16),

          // 5. Two-Column Ruled Table (Aligned on shared vertical axis)
          _tableRow(
            label1: isBangla ? 'মালিকানা অংশ' : 'Shares',
            val1: isBangla
                ? '${CurrencyFormatter.toBanglaDigits(totalShares.toString())}/১০০ অংশ'
                : '$totalShares of 100',
            label2: isBangla ? 'লট রেফারেন্স' : 'Lots',
            val2: 'LOT-041..044',
            palette: palette,
            isBangla: isBangla,
          ),
          const SizedBox(height: 10),
          _tableRow(
            label1: isBangla ? 'এসক্রো ব্যাংক' : 'Escrow Bank',
            val1: isBangla ? 'সিটি ব্যাংক (গুলশান)' : 'City Bank PLC',
            label2: isBangla ? 'বিতরণকৃত মুনাফা' : 'Dividends received',
            val2: CurrencyFormatter.format(realizedProfit, isBangla: isBangla),
            val2Color: palette.brassLight,
            palette: palette,
            isBangla: isBangla,
          ),
        ],
      ),
    );
  }

  Widget _tableRow({
    required String label1,
    required String val1,
    required String label2,
    required String val2,
    Color? val2Color,
    required AppPalette palette,
    required bool isBangla,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: AppTypography.caption(isBangla: isBangla).copyWith(
                  color: palette.canvas.withValues(alpha: 0.70),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                val1,
                style: AppTypography.bodyStrong(isBangla: isBangla).copyWith(
                  color: palette.canvas,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label2,
                style: AppTypography.caption(isBangla: isBangla).copyWith(
                  color: palette.canvas.withValues(alpha: 0.70),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                val2,
                style: AppTypography.bodyStrong(isBangla: isBangla).copyWith(
                  color: val2Color ?? palette.canvas,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Backward compatibility alias for PortfolioHeroCard
typedef PortfolioHeroCard = HoldingCard;
